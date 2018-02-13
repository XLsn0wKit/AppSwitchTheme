//
//  NSError+SkinManage.h
//  AFNetworking
//
//  Created by Touker on 2018/1/31.
//

#import <Foundation/Foundation.h>

typedef NSString * HBSkinErrorDomain NS_EXTENSIBLE_STRING_ENUM;
//SLSkinManage
UIKIT_EXTERN HBSkinErrorDomain const HBSKINMANAGEERRORDOMAIN;
//HBSkinDownloadManage
UIKIT_EXTERN HBSkinErrorDomain const HBSKINDOWNLOADMANAGEERRORDOMAIN;

typedef NS_ENUM(NSInteger, HBSkinManageErrorType) {
    HBSkinManageError_BundlePathNotFound =1,//
    HBSkinManageError_JsonParse =2,//
};

typedef NS_ENUM(NSInteger, HBSkinDownloadErrorType) {
    HBSkinDownloadError_TargetPathNotFound =11,//客户端错误，下载路径不存在
    HBSkinDownloadError_UrlNotFound =12,//客户端错误,下载的url不存在
    HBSkinDownloadError_TargetPathCreateFail =13,//客户端错误,目标路径创建失败,这样默认会下载在沙盒根路径下
    HBSkinDownloadError_UnZipFail =14,//客户端错误，zip解压缩失败
    HBSkinDownloadError_UnZipOpenFail =15,//客户端错误，zip文件打开失败
    HBSkinDownloadError_AppOther =19,//客户端其他类型错误
    HBSkinDownloadError_ServerError =21,//服务端错误
};

@interface NSError (SkinManage)
+ (NSError *)SkinErrorWithDomain:(HBSkinErrorDomain)domain code:(NSInteger)code userInfo:(NSDictionary *)dict;
@end
