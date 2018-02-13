//
//  HBSKinConst.h
//  AFNetworking
//
//  Created by Touker on 2018/2/1.
//
#pragma mark --皮肤配置文件(const)
//皮肤配置文件中颜色map对应的key值(colors:默认)
UIKIT_EXTERN NSString * const kSkinConfigColorForKey;
//皮肤配置文件中字体map对应的key值(fonts:默认)
UIKIT_EXTERN NSString * const kSkinConfigFontForKey;
//皮肤配置文件中字体map对应的key值(images:默认)
UIKIT_EXTERN NSString * const kSkinConfigImageForKey;
//皮肤配置文件中其他样式map对应的key值(others:默认)
UIKIT_EXTERN NSString * const kSkinConfigOtherForKey;
#pragma mark --图片相关参数(const)
//图片的子路径
UIKIT_EXTERN NSString * const HBImageSubpathKey;
//图片的类型
UIKIT_EXTERN NSString * const HBImageTypeKey;
#pragma mark --这一部分是作为SLSkinManage中私有的变量，但是为统一管理写到了这个地方
//默认的资源包ID
UIKIT_EXTERN NSString * const HBDefaultSourcesID;
//默认的样式配置文件名称
UIKIT_EXTERN NSString * const HBDefaultConfigName;
//默认的样式配置文件类型
UIKIT_EXTERN NSString * const HBDefaultConfigType;
#pragma mark --NSUserDefaults:本地存储皮肤配置Json和资源包ID对应的key
//存储样式配置对应的key
UIKIT_EXTERN NSString * const HBSkinConfigMapKey;
//存储样式配置ID对应的key
UIKIT_EXTERN NSString * const HBSkinBundleIDKey;
#pragma mark --下载相关配置
//下载的皮肤默认的地址
UIKIT_EXTERN NSString * const kSkinDownloadDefaultUrl;
//下载的皮肤默认保存的地址(沙盒相对路径)
UIKIT_EXTERN NSString * const HBSkinDownloadSubDirectory;
//皮肤资源包下载对应所属的NSSearchPathDirectory类型
UIKIT_EXTERN NSSearchPathDirectory const HBSkinDownloadDirectory;

