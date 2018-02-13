# SLSkinManage
## 简单介绍

>闲余时间写的一个换肤的小工具。目前的demo还比较简陋,还在持续更新。这个功能的设计仅仅根据自己的想法去实现的，看到的朋友可以借鉴一下，也许就更好的实现方式😊。

## 功能描述

>基本的安装(工程及沙盒路径)、切换皮肤功能，提供独立的下载模块(可替换)。
>可在xib、storyboard、纯代码布局中设置元素皮肤样式。
>UI样式、图片资源通过bundle以及文件来进行结构化的配置。

## 如何集成

>通过源码、pod等方式集成到工程中，添加皮肤资源包(下载等)并通过接口安装，在代码、布局文件中完成样式配置。
### 在storyboard中设置样式
![storyborad](https://github.com/lishuailibertine/SLSkinManage/blob/master/images/stordboard%402x.png)

## 接口使用

```objective-c
/** 三种安装方式根据具体的业务场景使用
 * 1,SLInstallSkinByName:安装工程路径下的皮肤资源包
 * 2,SLInstallSkinInSandboxByName:安装沙盒路径下的皮肤资源包
 * 3,SLInstallSkinByBundlePath:通过bundle资源路径安装皮肤资源包（工程或者沙盒）
 */
#define SLInstallSkinByName(bundleName,result) \
SLInstallSkinByBundlePath(SLGetBundlePath(bundleName),result);\

#define SLInstallSkinInSandboxByName(bundleName,result) \
SLInstallSkinByBundlePath(SLGetBundlePathInSandbox(bundleName),result);\

#define SLInstallSkinByBundlePath(bundlePath,result) \
[[SLSkinManage sharedSkinManage] installSkinByBundlePath:bundlePath installResult:result];\

/** 根据资源包bundle名切换皮肤*/
#define SLSwitchSkinByBundleID(bundleName) \
[[SLSkinManage sharedSkinManage] notifyUpdateByBundleID:bundleName];

/** 获取资源包路径接口
 * 1,SLGetBundlePath:获取工程路径下的皮肤资源包路径
 * 2,SLGetBundlePathInSandbox:获取工程路径下的皮肤资源包路径
 */
#define SLGetBundlePath(bundleName) \
([SLSkinManage getBundleWithBundleName:bundleName]).bundlePath\

#define SLGetBundlePathInSandbox(bundleName) \
([SLSkinManage getBundleInSandboxWithBundleName:bundleName directoryType:HBSkinDownloadDirectory inDirectory:HBSkinDownloadSubDirectory]).bundlePath\
```
## 元素样式设置
### 目前支持以下元素
|名称|属性及方法|注释|
|:---|:---|:---|
|UIView|skin_background_color|设置view的背景色|
|UIButton|skin_titleColor:forState:|设置按钮某个状态的title颜色|
||skin_imageNamed:forState:|设置按钮某个状态的image(根据配置表中的key)|
||skin_backgroundImageNamed:forState:|设置按钮某个状态的backgroundImag(根据配置表中的key)|
|UIImageView|skin_image|设置image(根据配置表中的key)|
|UILabel|skin_title_color|设置label的title颜色(根据配置表中的key)|
|UINavigationBar|skin_barBackground_image|用图片设置导航的背景色(根据配置表中的key)|
||skin_barBackground_color|用颜色设置导航的背景色(根据配置表中的key)|
|UITabBarItem|skin_image_name|用图片名设置tabbarIterm的image属性(根据配置表中的key)|
||skin_selectedImage_name|用图片名设置tabbarIterm的selectedImage属性(根据配置表中的key)|
|UITextField|skin_textFont|设置TextField的font大小(根据配置表中的key)|
||skin_textColor|设置TextField的textColor(根据配置表中的key)|
|UITextView|skin_textFont|设置UITextView的font大小(根据配置表中的key)|
||skin_textColor|设置UITextView的textColor(根据配置表中的key)|
|UISlider|skin_thumbTintColor|设置Slider的thumbTintColor属性(根据配置表中的key)|
||skin_minimumTrackTintColor|设置Slider的minimumTrackTintColor属性(根据配置表中的key)|
||skin_maximumTrackTintColor|设置Slider的maximumTrackTintColor属性(根据配置表中的key)|
|UISwitch|skin_onTintColor|设置Switch的onTintColor属性(根据配置表中的key)|
||skin_thumbTintColor|设置Switch的thumbTintColor属性(根据配置表中的key)|
|UIProgressView|skin_trackTintColor|设置ProgressView的trackTintColor属性(根据配置表中的key)|
||skin_progressTintColor|设置ProgressView的progressTintColor属性(根据配置表中的key)|
|UIPageControl|skin_pageIndicatorTintColor|设置PageControl的pageIndicatorTintColor属性(根据配置表中的key)|
||skin_currentPageIndicatorTintColor|设置PageControl的currentPageIndicatorTintColor属性(根据配置表中的key)|
|UISearchBar|skin_barTintColor|设置SearchBar的barTintColor属性(根据配置表中的key)|
|UIBarButtonItem|--|--|
