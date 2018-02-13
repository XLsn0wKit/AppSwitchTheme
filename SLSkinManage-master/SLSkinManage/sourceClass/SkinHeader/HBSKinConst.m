//
//  HBSKinConst.m
//  AFNetworking
//
//  Created by Touker on 2018/2/1.
//
#import "HBSkinDownloadManage.h"
#pragma mark --皮肤配置文件(const)
NSString * const kSkinConfigColorForKey =@"colors";
NSString * const kSkinConfigFontForKey =@"fonts";
NSString * const kSkinConfigImageForKey =@"images";
NSString * const kSkinConfigOtherForKey =@"others";
#pragma mark --图片相关参数(const)
//图片的子路径
NSString * const HBImageSubpathKey = @"images";
//图片的类型
NSString * const HBImageTypeKey = @"png";
#pragma mark --这一部分是作为SLSkinManage中私有的变量，但是为统一管理写到了这个地方
//默认的资源包ID
NSString * const HBDefaultSourcesID =@"SkinStyle_Light";
//默认的样式配置文件名称
NSString * const HBDefaultConfigName =@"skin";
//默认的样式配置文件类型
NSString * const HBDefaultConfigType =@"json";
#pragma mark --NSUserDefaults:本地存储皮肤配置Json和资源包ID对应的key
//存储样式配置对应的key
NSString * const HBSkinConfigMapKey = @"HBSkinConfigMapKey";
//存储样式配置ID对应的key
NSString * const HBSkinBundleIDKey = @"HBSkinBundleIDKey";
#pragma mark --下载相关配置
NSString * const kSkinDownloadDefaultUrl =@"http://s1.music.126.net/download/skin/1475210054939_cat.zip";
//皮肤资源包下载对应所属的NSSearchPathDirectory类型
NSSearchPathDirectory const HBSkinDownloadDirectory =NSLibraryDirectory;
//皮肤资源包下载沙盒对应的子路径
NSString * const HBSkinDownloadSubDirectory =@"/HBUserSkins";
