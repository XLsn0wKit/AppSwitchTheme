//
//  HBSkinDownManage.m
//  SLTestViewAnimation
//
//  Created by Touker on 2017/12/8.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import "HBSkinDownloadManage.h"
#import "AFNetworking.h"
#import "ZipArchive.h"
#import "HBSkinConst.h"
@implementation HBSkinDownloadParams
- (NSString *)url
{
    if(!_url){
        _url = kSkinDownloadDefaultUrl;;
    }
    return _url;
}
- (NSString *)destinationPath
{
    if(!_destinationPath){
        _destinationPath = HBSkinDownloadSubDirectory;
    }
    return _destinationPath;
}
- (instancetype)createDownloadParamWithUrl:(NSString *)url destinationPath:(NSString *)destinationPath
{
    HBSkinDownloadParams * downloadParams =[[HBSkinDownloadParams alloc] init];
    downloadParams.url =url;
    downloadParams.destinationPath =destinationPath;
    return downloadParams;
}
@end
@implementation HBSkinDownloadResponse
@end

static AFURLSessionManager *_sessionManager =nil;
static NSURLSessionConfiguration *_sessionConfiguration =nil;

@implementation HBSkinDownloadManage
+ (NSURLSessionConfiguration *)sessionConfiguration
{
    if (!_sessionConfiguration) {
        _sessionConfiguration =[NSURLSessionConfiguration defaultSessionConfiguration];
    }
    return _sessionConfiguration;
}
+ (AFURLSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager =[[AFURLSessionManager alloc] initWithSessionConfiguration:self.sessionConfiguration];
        _sessionManager.responseSerializer= [AFHTTPResponseSerializer serializer];
    }
    return _sessionManager;
}
//创建下载任务
+ (void)downloadSkinSourceByParams:(HBSkinDownloadParams *)params resultBlock:(void(^)(NSError *error))resultBlock
{
    AFURLSessionManager *manager = [self sessionManager];
    if(!params){
        params =[[HBSkinDownloadParams alloc] init];
    }
    if(!params.destinationPath){
        resultBlock([NSError SkinErrorWithDomain:HBSKINDOWNLOADMANAGEERRORDOMAIN code:HBSkinDownloadError_TargetPathNotFound userInfo:nil]);
        return;
    }
    if(!params.url){
        resultBlock([NSError SkinErrorWithDomain:HBSKINDOWNLOADMANAGEERRORDOMAIN code:HBSkinDownloadError_UrlNotFound userInfo:nil]);
        return;
    }
    NSURL *URL = [NSURL URLWithString:params.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        if([HBSkinDownloadManage createTargetPath:params.destinationPath params:params]){
            return [[self directory:params] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",params.destinationPath,[response suggestedFilename]]];
        }else{
            resultBlock([NSError SkinErrorWithDomain:HBSKINDOWNLOADMANAGEERRORDOMAIN code:HBSkinDownloadError_TargetPathCreateFail userInfo:nil]);
            return [self directory:params];
        }
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if(error){
            resultBlock([NSError SkinErrorWithDomain:HBSKINDOWNLOADMANAGEERRORDOMAIN code:HBSkinDownloadError_AppOther userInfo:error.userInfo]);
        }else{
            NSError *error = [self unzipWithZipPath:filePath.path isUnZipedPath:[self getTargetAbsolutePath:params.destinationPath params:params] removeZip:params.isRemove];
            if(error){
                resultBlock(error);
            }else{
                resultBlock(nil);
            }
        }
    }];
    [downloadTask resume];
}
//解压缩zip包
+ (NSError *)unzipWithZipPath:(NSString *)ZipPath isUnZipedPath:(NSString *)path removeZip:(BOOL)removeZip
{
    ZipArchive *zipArchive = [[ZipArchive alloc] init];
    if([zipArchive UnzipOpenFile:ZipPath]){
        if([zipArchive UnzipFileTo:path overWrite:YES]){
            [zipArchive UnzipCloseFile];
            if(removeZip){
                NSError *error;
                [[NSFileManager defaultManager] removeItemAtPath:ZipPath error:&error];
            }
            return nil;
        }else{
            [zipArchive UnzipCloseFile];
            return [NSError SkinErrorWithDomain:HBSKINDOWNLOADMANAGEERRORDOMAIN code:HBSkinDownloadError_UnZipFail userInfo:nil];
        }
    }else{
        [zipArchive UnzipCloseFile];
        return [NSError SkinErrorWithDomain:HBSKINDOWNLOADMANAGEERRORDOMAIN code:HBSkinDownloadError_UnZipOpenFail userInfo:nil];
    }
    return nil;
}
//创建目标路径 targetPath:相对路径
+ (BOOL)createTargetPath:(NSString *)targetPath params:(HBSkinDownloadParams *)params
{
    if(![[NSFileManager defaultManager] fileExistsAtPath:[self getTargetAbsolutePath:targetPath params:params]]){
        return [[NSFileManager defaultManager] createDirectoryAtPath:[self getTargetAbsolutePath:targetPath params:params] withIntermediateDirectories:YES attributes:nil error:nil];
    }else
        return YES;
}
//获取目标的绝对路径
+ (NSString *)getTargetAbsolutePath:(NSString *)targetPath params:(HBSkinDownloadParams *)params
{
    return [NSString stringWithFormat:@"%@%@",[self directory:params].path,targetPath];
}
+ (NSURL *)directory:(HBSkinDownloadParams *)params
{
    NSSearchPathDirectory directoryType = params.directoryType==HBSkinDirectoryType_Library?NSDocumentDirectory:NSLibraryDirectory;
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:directoryType inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    return documentsDirectoryURL;
}
@end

