//
//  SLSkinManage.m
//  AFNetworking
//
//  Created by Touker on 2018/1/31.
//

#import "SLSkinManage.h"
#import "NSObject+HBSkinNotify.h"
@interface SLSkinManage()
@property (nonatomic, strong) NSMutableDictionary *sourcesMap;
/**观察者对象容器*/
@property (nonatomic, strong) NSMutableDictionary *observerDic;
@end

@implementation SLSkinManage
+ (instancetype)sharedSkinManage{
    static id _skinManage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^(void) {
        _skinManage = [[self alloc] init];
        [_skinManage installSkinByBundlePath:([SLSkinManage getBundleWithBundleName:HBDefaultSourcesID]).bundlePath installResult:^(NSError *error) {
            NSAssert(error==nil, @"install default fail:%@",error.userInfo);
            [_skinManage saveCurrentSkinBundleID:HBDefaultSourcesID];
        }];
    });
    return _skinManage;
}
#pragma mark --setter getter
- (NSMutableDictionary *)sourcesMap{
    if (!_sourcesMap) {
        _sourcesMap =[NSMutableDictionary dictionary];
    }
    return _sourcesMap;
}
- (NSDictionary *)getCurrentConfig{
    return [self getConfigWithBundleID:[self getCurrentSkinBundleID]];
}
#pragma mark --public
- (void)installSkinByBundlePath:(NSString *)bundlePath installResult:(SkinInstallCallback)installResult{
    [self installSkinByBundlePath:bundlePath configName:nil configType:nil installResult:installResult];
}
- (void)installSkinByBundlePath:(NSString *)bundlePath
                     configName:(NSString *)configName
                     configType:(NSString *)configType
                  installResult:(SkinInstallCallback)installResult{
    if (bundlePath==nil||bundlePath.length==0) {
        if (installResult) {
            installResult([NSError SkinErrorWithDomain:HBSKINMANAGEERRORDOMAIN code:HBSkinManageError_BundlePathNotFound userInfo:nil]);
        }
        return;
    }
    if (configName==nil||configName.length==0) {
        configName=HBDefaultConfigName;
    }
    if (configType==nil||configType.length==0) {
        configType =HBDefaultConfigType;
    }
    @try{
        __weak typeof(self) this =self;
        NSString * configPath =[NSString stringWithFormat:@"%@/%@.%@",bundlePath,configName,configType];
        [SLSkinManage filePathToDic:configPath result:^(NSError *error, NSDictionary *dataDic) {
            if (error) {
                if (installResult) {
                    installResult([NSError SkinErrorWithDomain:HBSKINMANAGEERRORDOMAIN code:HBSkinManageError_JsonParse userInfo:nil]);
                }else{
                    NSAssert(error==nil, @"%@",error.userInfo);
                }
                return;
            }else{
                [this saveConfigWithBundleID:[bundlePath.lastPathComponent stringByDeletingPathExtension] skinConfig:dataDic];
                if (installResult) {
                    installResult(nil);
                }
            }
        }];
    }
    @catch(NSException *exception){
        NSAssert(exception==nil, @"%@",exception.reason);
    }
}
//安装完，需手动根据bundleID进行皮肤更新
- (void)notifyUpdateByBundleID:(NSString *)bundleID{
    if (bundleID==nil||bundleID.length==0) {
        NSAssert((bundleID||bundleID.length>=0), @"bundleID is error");
        return;
    }
    NSDictionary * configMap =[self getConfigWithBundleID:bundleID];
    if (configMap==nil) {
        NSLog(@"%@ is not installed",bundleID);
        return;
    }
    [self saveCurrentSkinBundleID:bundleID];
    [[NSNotificationCenter defaultCenter] postNotificationName:HBNotificationSkinUpdate object:nil];
    [SLSkinManage notifyObserver];
}
+ (void)registerCallbackWithKey:(NSString *)key skinUpdateCallback:(SkinUpdateCallback)skinUpdateCallback{
    if (key&&key.length>0&&skinUpdateCallback) {
        [[SLSkinManage sharedSkinManage].observerDic setObject:skinUpdateCallback forKey:key];
    }
}
+ (void)removeCallbackWithKey:(NSString *)key{
    if(key&&key.length>0){
        if([[SLSkinManage sharedSkinManage].observerDic objectForKey:key]){
            [[SLSkinManage sharedSkinManage].observerDic removeObjectForKey:key];
        }
    }
}
#pragma mark --private
+ (void)notifyObserver{
    for (SkinUpdateCallback callback in [[SLSkinManage sharedSkinManage].observerDic allValues]) {
        callback([[SLSkinManage sharedSkinManage] getCurrentSkinBundleID]);
    }
}
#pragma mark --ConfigDic
- (void)saveConfigWithBundleID:(NSString *)bundleID skinConfig:(NSDictionary *)skinConfig{
    NSDictionary *configMap =[SLSkinManage getSourcesConfigForKey:HBSkinConfigMapKey];
    [self.sourcesMap addEntriesFromDictionary:configMap];
    [self.sourcesMap setValue:skinConfig forKey:bundleID];
    [SLSkinManage saveSourcesConfig:self.sourcesMap forKey:HBSkinConfigMapKey];
}
- (NSDictionary *)getConfigWithBundleID:(NSString *)bundleID{
    return [[SLSkinManage getSourcesConfigForKey:HBSkinConfigMapKey] objectForKey:bundleID];
}
#pragma mark --SkinBundleID
- (void)saveCurrentSkinBundleID:(NSString *)bundleID{
    [SLSkinManage saveSourcesConfig:bundleID forKey:HBSkinBundleIDKey];
}
- (NSString *)getCurrentSkinBundleID{
    return [SLSkinManage getSourcesConfigForKey:HBSkinBundleIDKey];
}
@end

@implementation SLSkinManage (SLSkinSourceManage)
+ (NSBundle *)getBundleWithBundleName:(NSString *)bundleName {
    if (bundleName==nil||bundleName.length==0) {
        NSLog(@"please add bundleName");
    }
    NSBundle *bundle = [NSBundle mainBundle];
    if (bundleName.length) {
        bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"]];
    }
    return bundle;
}
+ (NSBundle *)getBundleInSandboxWithBundleName:(NSString *)bundleName directoryType:(NSSearchPathDirectory)directoryType inDirectory:(NSString *)subPath{
    if (bundleName==nil||bundleName.length==0) {
        NSLog(@"please add bundleName");
    }
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:directoryType inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSString *bundlePath = [NSString stringWithFormat:@"%@%@/%@.bundle",documentsDirectoryURL.path,subPath,bundleName];
    return [NSBundle bundleWithPath:bundlePath];
}
+ (NSString *)getImagePathWithBundle:(NSBundle *)bundle imageName:(NSString *)imageName imageType:(NSString *)fileType inDirectory:(NSString *)subPath{
    if (bundle==nil) {
        bundle =[NSBundle mainBundle];
    }
    if (fileType==nil||fileType.length<=0) {
        fileType =@"png";
    }
    NSInteger scale = [[UIScreen mainScreen] scale];
    NSString *name = [NSString stringWithFormat:@"%@@%zdx",imageName,scale];
    NSString *imagePath = [bundle pathForResource:name ofType:fileType inDirectory:subPath];
    return imagePath;
}
+ (void)saveSourcesConfig:(id)object forKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object=object?object:[NSNull null] forKey:key];
    [defaults synchronize];
}
+ (id)getSourcesConfigForKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return  [defaults objectForKey:key];
}
+ (void)filePathToDic:(NSString *)filePath result:(void(^)(NSError *error,NSDictionary *dataDic))result{
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    NSDictionary *jsonDic;
    if (fileData) {
        jsonDic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
    }
    if (error) {
        result(error,nil);
    }else{
        result(nil,jsonDic);
    }
}
@end
