//
//  ChangeSkinService.m
//  ChangeSkin
//
//  Created by Agenric on 2016/12/12.
//  Copyright © 2016年 Agenric. All rights reserved.
//

#import "ChangeSkinService.h"
#import <AFNetworking/AFNetworking.h>
#import <SSZipArchive/SSZipArchive.h>
#import "UIImage+ChangeSkin.h"

#define ChangeSkinUrl           @"http://10.75.85.204/api/index/newChangeSkin"

static NSString * const CS_downloadPackageIdsKey = @"ChangeSkindownloadPackageIdsKey";

static inline NSURL * DocumentsDirectoryURL() {
    return [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
}

static inline NSString * ConfigFile() {
    return [[DocumentsDirectoryURL() path] stringByAppendingPathComponent:@"/ChangeSkin.plist"];
}

static inline NSString * ResourceFile() {
    return [[DocumentsDirectoryURL() path] stringByAppendingPathComponent:@"/SkinFile"];
}

@interface ChangeSkinService ()

/**
 当前需显示的资源id
 */
@property (nonatomic, copy) NSString *currentShowId;

/**
 当前服务器有效的资源包列表{'packageId' => '8','iosUrl' => 'http://agenric.b0.upaiyun.com/changeskin.zip'}
 */
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *serverPackages;

/**
 当前客户端未缓存完成的资源列表
 */
@property (nonatomic, strong) NSMutableArray<NSString *> *unDownloadPackageIds;

/**
 当前客户端已缓存完成的资源列表
 */
@property (nonatomic, strong) NSMutableArray<NSString *> *downloadPackageIds;

/**
 是否需要更换资源
 */
@property (nonatomic, assign, readwrite) BOOL shouldChangeSkin;

@end

@implementation ChangeSkinService

#pragma mark - Life Cycle
+ (id)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configMetadata];
    }
    return self;
}

/**
 配置原始数据
 */
- (void)configMetadata {
    // 1、先设置默认不允许更换资源
    self.shouldChangeSkin = NO;
    // 2、读取Document文件夹下plist文件，如果不存在该文件则创建
    NSMutableDictionary *configDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:ConfigFile()];
    if (!configDictionary) {
        configDictionary = [NSMutableDictionary dictionary];
        [configDictionary setValue:[NSMutableArray array] forKey:CS_downloadPackageIdsKey];
        
        [[NSFileManager defaultManager] createFileAtPath:ConfigFile() contents:nil attributes:nil];
        [configDictionary writeToFile:ConfigFile() atomically:NO];
    }
    self.downloadPackageIds = [NSMutableArray arrayWithArray:[configDictionary valueForKey:CS_downloadPackageIdsKey]];
}

- (NSString *)resourceFile {
    return [ResourceFile() stringByAppendingString:[NSString stringWithFormat:@"/%@", self.currentShowId]];
}

#pragma mark - Private Methods
- (void)configService {
    // 请求换肤接口
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:ChangeSkinUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]){
            NSLog(@"皮肤接口有误");
            return;
        }
        NSDictionary *responseDictionary = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([[responseDictionary valueForKey:@"errorCode"] isEqual:@"0"]) {
            // 查看当前是否有需要显示的资源id
            if ([responseDictionary valueForKey:@"showId"] && [[responseDictionary valueForKey:@"showId"] length] > 0) {
                if ([strongSelf.downloadPackageIds containsObject:[responseDictionary valueForKey:@"showId"]]) {
                    strongSelf.shouldChangeSkin = YES;
                    strongSelf.currentShowId = [responseDictionary valueForKey:@"showId"];
                }
            }
            
            // 查看最近是否有需要下载的资源
            if ([responseDictionary valueForKey:@"packages"] && [[responseDictionary valueForKey:@"packages"] count] > 0) {
                strongSelf.serverPackages = [NSMutableArray arrayWithArray:[responseDictionary valueForKey:@"packages"]];
            }
            [strongSelf handleServerData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"皮肤接口有误 - %@", error);
    }];
    
}

- (void)handleServerData {
    self.unDownloadPackageIds = [NSMutableArray array];
    // 遍历当前服务器有效的资源,添加到未下载列表
    [self.serverPackages enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.unDownloadPackageIds addObject:[obj valueForKey:@"packageId"]];
    }];
    
    // 遍历已下载列表，剔除已过期的资源用以删除
    __block NSMutableArray<NSString *> *unAvailablePackages = [NSMutableArray array];
    [self.downloadPackageIds enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![self.unDownloadPackageIds containsObject:obj]) {
            [unAvailablePackages addObject:obj];
        }
    }];
    
    // 删除已经过期的资源文件
    [unAvailablePackages enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager removeItemAtPath:[ResourceFile() stringByAppendingString:[NSString stringWithFormat:@"/%@", obj]] error:nil]) {
            [self.downloadPackageIds removeObject:obj];
        };
    }];
    
    [self.unDownloadPackageIds removeObjectsInArray:self.downloadPackageIds];
    
    if (self.unDownloadPackageIds.count > 0) { // 有新资源需要下载
        [self handleDownload];
    } else { // 无新资源需要下载
        NSMutableDictionary *configDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:ConfigFile()];
        [configDictionary setValue:self.downloadPackageIds forKey:CS_downloadPackageIdsKey];
        [configDictionary writeToFile:ConfigFile() atomically:YES];
    }
}

/**
 处理需要下载的资源
 */
- (void)handleDownload {
    if (self.serverPackages.count > 0) {
        NSDictionary *package = [self.serverPackages firstObject];
        if ([self.downloadPackageIds containsObject:[package valueForKey:@"packageId"]]) {
            [self.serverPackages removeObjectAtIndex:0];
            [self handleDownload];
        } else {
            [self downloadResourceWithPackageUrl:[package valueForKey:@"iosUrl"] andPackageId:[package valueForKey:@"packageId"]];
        }
    }
}

/**
 根据url和id下载资源

 @param packageUrl 资源url
 @param packageId 资源id
 */
- (void)downloadResourceWithPackageUrl:(NSString *)packageUrl andPackageId:(NSString *)packageId {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:packageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [DocumentsDirectoryURL() URLByAppendingPathComponent:packageId];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error == nil) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [SSZipArchive unzipFileAtPath:[filePath path] toDestination:[ResourceFile() stringByAppendingString:[NSString stringWithFormat:@"/%@",packageId]] overwrite:YES password:@"password" progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {
                
            } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nonnull error) {
                if (succeeded) {
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    [fileManager removeItemAtPath:[filePath path] error:nil];
                    [strongSelf handleDataWithPackageId:packageId];
                } else {
                    NSLog(@"解压出错 - %@", error);
                }
            }];
        } else {
            NSLog(@"下载出错 - %@", error);
        }
    }];
    [downloadTask resume];
}

// 最新资源包已经下载完成，处理后续操作
- (void)handleDataWithPackageId:(NSString *)packageId {
    // 删除未下载的文件的标记
    [self.serverPackages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj valueForKey:@"packageId"] isEqualToString:packageId]) {
            [self.serverPackages removeObject:obj];
            [self.downloadPackageIds addObject:packageId];
            *stop = YES;
        }
    }];
    
    // 查看是否还有未下载的资源，如有则继续下载
    if (self.serverPackages.count > 0) {
        [self handleDownload];
    } else {
        NSMutableDictionary *configDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:ConfigFile()];
        [configDictionary setValue:self.downloadPackageIds forKey:CS_downloadPackageIdsKey];
        [configDictionary writeToFile:ConfigFile() atomically:YES];
    }
}

@end

