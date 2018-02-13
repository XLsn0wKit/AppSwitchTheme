//
//  NSObject+HBSkinKit.m
//  AFNetworking
//
//  Created by Touker on 2018/2/5.
//

#import "NSObject+HBSkinKit.h"
#import "NSObject+HBSkinNotify.h"
#import "SLSkinStyleParse.h"
@implementation UIView (HBSkin)
static char backgroundColorKey;
#pragma mark -private
- (void)setSl_backgroundColor:(NSString *)sl_backgroundColor{
    objc_setAssociatedObject(self, &backgroundColorKey, sl_backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_backgroundColor{
    return objc_getAssociatedObject(self, &backgroundColorKey);
}
#pragma mark -public
- (void)setSkin_background_color:(NSString *)skin_background_color{
    [self setObserver:self];
    if (skin_background_color) {
        self.sl_backgroundColor =skin_background_color;
        [self updateBackgroundColor];
    }
}
- (NSString *)skin_background_color{
    return self.sl_backgroundColor;
}
- (void)updateStyle{
    if (self.sl_backgroundColor) {
        [self updateBackgroundColor];
    }
}
#pragma mark private
- (void)updateBackgroundColor{
    self.backgroundColor =[SLSkinStyleParse colorForKey:self.sl_backgroundColor];
}
@end

static char btnImageStateKey,btnBackgroundImageStateKey,btnTextTitleColorStateKey,buttonImageKey,buttonBackgroundImageKey,btnTextTitleColorKey;
@implementation UIButton (HBSkin)
#pragma mark -public
- (void)setSkin_imageState:(UIControlState)skin_imageState{
    objc_setAssociatedObject(self, &btnImageStateKey,@(skin_imageState), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIControlState)skin_imageState{
    NSNumber * obj = objc_getAssociatedObject(self, &btnImageStateKey);
    return obj==nil?0:[obj intValue];
}
- (void)setSkin_backgroundImageState:(UIControlState)skin_backgroundImageState{
    objc_setAssociatedObject(self, &btnBackgroundImageStateKey,@(skin_backgroundImageState), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIControlState)skin_backgroundImageState{
    NSNumber * obj = objc_getAssociatedObject(self, &btnBackgroundImageStateKey);
    return obj==nil?0:[obj intValue];
}
- (void)setSkin_textTitleColorState:(UIControlState)skin_textTitleColorState{
    objc_setAssociatedObject(self, &btnTextTitleColorStateKey,@(skin_textTitleColorState), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIControlState)skin_textTitleColorState{
    NSNumber * obj = objc_getAssociatedObject(self, &btnTextTitleColorStateKey);
    return obj==nil?0:[obj intValue];
}
- (void)setSkin_buttonImage:(NSString *)skin_buttonImage{
    objc_setAssociatedObject(self, &buttonImageKey, skin_buttonImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)skin_buttonImage{
    return objc_getAssociatedObject(self, &buttonImageKey);
}
- (void)setSkin_buttonBackgroundImage:(NSString *)skin_buttonBackgroundImage{
    objc_setAssociatedObject(self, &buttonBackgroundImageKey, skin_buttonBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)skin_buttonBackgroundImage{
    return objc_getAssociatedObject(self, &buttonBackgroundImageKey);
}
- (void)setSkin_textTitleColor:(NSString *)skin_textTitleColor{
    objc_setAssociatedObject(self, &btnTextTitleColorKey, skin_textTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)skin_textTitleColor{
    return objc_getAssociatedObject(self, &btnTextTitleColorKey);
}

- (void)skin_titleColor:(NSString *)type forState:(UIControlState)state{
    [self setObserver:self];
    UIColor *textColor =[SLSkinStyleParse colorForKey:type];
    if (textColor) {
        self.skin_textTitleColor = type;
        self.skin_textTitleColorState =state;
        [self setTitleColor:textColor forState:state];
    }
}
- (void)skin_imageNamed:(NSString *)name forState:(UIControlState)state{
    [self setObserver:self];
    UIImage *image =[SLSkinStyleParse imageForKey:name];
    if (image) {
        self.skin_buttonImage =name;
        self.skin_imageState =state;
        [self setImage:image forState:state];
    }
}
- (void)skin_backgroundImageNamed:(NSString *)name forState:(UIControlState)state{
    [self setObserver:self];
    UIImage *backGroundImage =[SLSkinStyleParse imageForKey:name];
    if (backGroundImage) {
        self.skin_buttonBackgroundImage =name;
        self.skin_backgroundImageState =state;
        [self setBackgroundImage:backGroundImage forState:state];
    }
}
- (void)updateStyle{
    [super updateStyle];
    if (self.skin_buttonImage) {
        [self setImage:[SLSkinStyleParse imageForKey:self.skin_buttonImage] forState:self.skin_imageState];
    }
    if (self.skin_buttonBackgroundImage) {
        [self setBackgroundImage:[SLSkinStyleParse imageForKey:self.skin_buttonBackgroundImage]  forState:self.skin_backgroundImageState];
    }
    if (self.skin_textTitleColor) {
        [self setTitleColor:[SLSkinStyleParse colorForKey:self.skin_textTitleColor] forState:self.skin_textTitleColorState];
    }
}
@end

static char ImageKey;
@implementation UIImageView (HBSkin)

- (void)setSl_Image:(NSString *)sl_Image{
    objc_setAssociatedObject(self, &ImageKey, sl_Image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_Image{
    return objc_getAssociatedObject(self, &ImageKey);
}
#pragma mark -public
- (void)setSkin_image:(NSString *)skin_image{
    [self setObserver:self];
    if (skin_image) {
        self.sl_Image =skin_image;
        [self updateStyle];
    }
}
- (NSString *)skin_image{
    return self.sl_Image;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.skin_image) {
        self.image =[SLSkinStyleParse imageForKey:self.skin_image];
    }
}
@end

@implementation UILabel (HBSkin)
static char textColorKey;
#pragma mark -private
- (void)setSl_textColor:(NSString *)textColor{
    objc_setAssociatedObject(self, &textColorKey, textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_textColor{
    return objc_getAssociatedObject(self, &textColorKey);
}
#pragma mark -public
- (void)setSkin_title_color:(NSString *)skin_title_color{
    [self setObserver:self];
    if (skin_title_color) {
        self.sl_textColor =skin_title_color;
        [self updateTitleColor];
    }
}
- (NSString *)skin_title_color{
    return self.sl_textColor;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.sl_textColor) {
        [self updateTitleColor];
    }
}
#pragma mark private
- (void)updateTitleColor{
    self.textColor =[SLSkinStyleParse colorForKey:self.sl_textColor];
}
@end


@implementation UINavigationBar (HBSkin)
static char barBackgroundImageKey;
static char barBackgroundColorKey;
#pragma mark -private
- (void)setSl_barBackgroundImage:(NSString *)sl_barBackgroundImage{
    objc_setAssociatedObject(self, &barBackgroundImageKey, sl_barBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_barBackgroundImage{
    return objc_getAssociatedObject(self, &barBackgroundImageKey);
}
- (void)setSl_barBackgroundColor:(NSString *)sl_barBackgroundColor{
    objc_setAssociatedObject(self, &barBackgroundColorKey, sl_barBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_barBackgroundColor{
    return objc_getAssociatedObject(self, &barBackgroundColorKey);
}
#pragma mark -public
- (void)setSkin_barBackground_image:(NSString *)skin_barBackground_image{
    [self setObserver:self];
    if (skin_barBackground_image) {
        self.sl_barBackgroundImage =skin_barBackground_image;
        [self updateBarBackgroundImage];
    }
}
- (NSString *)skin_barBackground_image{
    return self.sl_barBackgroundImage;
}
- (void)setSkin_barBackground_color:(NSString *)skin_barBackground_color{
    [self setObserver:self];
    if (skin_barBackground_color) {
        self.sl_barBackgroundColor =skin_barBackground_color;
        [self updateBarBackgroundColor];
    }
}
- (NSString *)skin_barBackground_color{
    return self.sl_barBackgroundColor;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.sl_barBackgroundImage) {
        [self updateBarBackgroundImage];
    }
    if (self.sl_barBackgroundColor) {
        [self updateBarBackgroundColor];
    }
}
#pragma mark private
- (void)updateBarBackgroundImage{
    [self navigationBarColorImage:[SLSkinStyleParse imageForKey:self.sl_barBackgroundImage]];
}
- (void)updateBarBackgroundColor{
    [self navigationBarColor:[SLSkinStyleParse colorForKey:self.sl_barBackgroundColor]];
}
-(void)navigationBarColorImage:(UIImage *)image{
    self.translucent = NO;
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
-(void)navigationBarColor:(UIColor *)color{
    self.translucent = NO;
    [self setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
}
@end

@implementation UITabBarItem (HBSkin)
static char tabbarImageNameKey;
static char tabbarSelectedImageNameKey;
#pragma mark -private
- (void)setSl_imageName:(NSString *)sl_imageName{
    objc_setAssociatedObject(self, &tabbarImageNameKey, sl_imageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_imageName{
    return objc_getAssociatedObject(self, &tabbarImageNameKey);
}

- (void)setSl_selectedImage:(NSString *)sl_selectedImage{
    objc_setAssociatedObject(self, &tabbarSelectedImageNameKey, sl_selectedImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_selectedImage{
    return objc_getAssociatedObject(self, &tabbarSelectedImageNameKey);
}
#pragma mark -public
- (void)setSkin_image_name:(NSString *)skin_image_name{
    [self setObserver:self];
    if (skin_image_name) {
        self.sl_imageName =skin_image_name;
        [self updateTabBarItemImage];
    }
}
- (NSString *)skin_image_name{
    return self.sl_imageName;
}

- (void)setSkin_selectedImage_name:(NSString *)skin_selectedImage_name{
    [self setObserver:self];
    if (skin_selectedImage_name) {
        self.sl_selectedImage =skin_selectedImage_name;
        [self updateTabBarItemSelectedImage];
    }
}
- (NSString *)skin_selectedImage_name{
    return self.sl_selectedImage;
}
- (void)updateStyle{
    if (self.sl_imageName) {
        [self updateTabBarItemImage];
    }
    if (self.sl_selectedImage) {
        [self updateTabBarItemSelectedImage];
    }
}
#pragma mark private
- (void)updateTabBarItemImage{
    self.image =[SLSkinStyleParse imageForKey:self.sl_imageName];
}
- (void)updateTabBarItemSelectedImage{
    self.selectedImage =[SLSkinStyleParse imageForKey:self.sl_selectedImage];
}
@end

@implementation UITextField (HBSkin)
static char textFiedTextFontKey,textFieldTextColor;

#pragma mark private
- (void)setSl_textFont:(NSString *)sl_textFont{
    objc_setAssociatedObject(self, &textFiedTextFontKey, sl_textFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_textFont{
    return objc_getAssociatedObject(self, &textFiedTextFontKey);
}

- (void)setSl_textColor:(NSString *)sl_textColor{
    objc_setAssociatedObject(self, &textFieldTextColor, sl_textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_textColor{
    return objc_getAssociatedObject(self, &textFieldTextColor);
}
#pragma mark public
- (void)setSkin_textFont:(NSString *)skin_textFont{
    [self setObserver:self];
    if (skin_textFont) {
        self.sl_textFont =skin_textFont;
        [self updateTextFieldTextFont];
    }
}
- (NSString *)skin_textFont{
    return self.sl_textFont;
}
- (void)setSkin_textColor:(NSString *)skin_textColor{
    [self setObserver:self];
    if (skin_textColor) {
        self.sl_textColor =skin_textColor;
        [self updateTextFieldTextColor];
    }
}
- (NSString *)skin_textColor{
    return self.sl_textColor;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.sl_textFont) {
        [self updateTextFieldTextFont];
    }
    if (self.sl_textColor) {
        [self updateTextFieldTextColor];
    }
}
#pragma mark private
- (void)updateTextFieldTextFont{
    self.font =[SLSkinStyleParse fontForKey:self.sl_textFont];
}
- (void)updateTextFieldTextColor{
    self.textColor =[SLSkinStyleParse colorForKey:self.sl_textColor];
}
@end
@implementation UITextView (HBSkin)

static char textViewTextFontKey,textViewTextColor;
#pragma mark private
- (void)setSl_textFont:(NSString *)sl_textFont{
    objc_setAssociatedObject(self, &textViewTextFontKey, sl_textFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_textFont{
    return objc_getAssociatedObject(self, &textViewTextFontKey);
}

- (void)setSl_textColor:(NSString *)sl_textColor{
    objc_setAssociatedObject(self, &textViewTextColor, sl_textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_textColor{
    return objc_getAssociatedObject(self, &textViewTextColor);
}
#pragma mark public
- (void)setSkin_textFont:(NSString *)skin_textFont{
    [self setObserver:self];
    if (skin_textFont) {
        self.sl_textFont =skin_textFont;
        [self updateTextViewTextFont];
    }
}
- (NSString *)skin_textFont{
    return self.sl_textFont;
}
- (void)setSkin_textColor:(NSString *)skin_textColor{
    [self setObserver:self];
    if (skin_textColor) {
        self.sl_textColor =skin_textColor;
        [self updateTextViewTextColor];
    }
}
- (NSString *)skin_textColor{
    return self.sl_textColor;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.sl_textFont) {
        [self updateTextViewTextFont];
    }
    if (self.sl_textColor) {
        [self updateTextViewTextColor];
    }
}
#pragma mark private
- (void)updateTextViewTextFont{
    self.font =[SLSkinStyleParse fontForKey:self.sl_textFont];
}
- (void)updateTextViewTextColor{
    self.textColor =[SLSkinStyleParse colorForKey:self.sl_textColor];
}
@end
@implementation UISlider (HBSkin)
static char sliderThumbTintColorKey,sliderMinimumTrackTintColorKey,sliderMaximumTrackTintColorKey;
#pragma mark private
- (void)setSl_thumbTintColor:(NSString *)sl_thumbTintColor{
    objc_setAssociatedObject(self, &sliderThumbTintColorKey, sl_thumbTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_thumbTintColor{
    return objc_getAssociatedObject(self, &sliderThumbTintColorKey);
}
- (void)setSl_minimumTrackTintColor:(NSString *)sl_minimumTrackTintColor{
    objc_setAssociatedObject(self, &sliderMinimumTrackTintColorKey, sl_minimumTrackTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_minimumTrackTintColor{
    return objc_getAssociatedObject(self, &sliderMinimumTrackTintColorKey);
}
- (void)setSl_maximumTrackTintColor:(NSString *)sl_maximumTrackTintColor{
    objc_setAssociatedObject(self, &sliderMaximumTrackTintColorKey, sl_maximumTrackTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_maximumTrackTintColor{
    return objc_getAssociatedObject(self, &sliderMaximumTrackTintColorKey);
}
#pragma mark public
- (void)setSkin_thumbTintColor:(NSString *)skin_thumbTintColor{
    [self setObserver:self];
    if (skin_thumbTintColor) {
        self.sl_thumbTintColor =skin_thumbTintColor;
        [self updateThumbTintColor];
    }
}
- (NSString *)skin_thumbTintColor{
    return self.sl_thumbTintColor;
}
- (void)setSkin_minimumTrackTintColor:(NSString *)skin_minimumTrackTintColor{
    [self setObserver:self];
    if (skin_minimumTrackTintColor) {
        self.sl_minimumTrackTintColor =skin_minimumTrackTintColor;
        [self updateThumbTintColor];
    }
}
- (NSString *)skin_minimumTrackTintColor{
    return self.sl_minimumTrackTintColor;
}
- (void)setSkin_maximumTrackTintColor:(NSString *)skin_maximumTrackTintColor{
    [self setObserver:self];
    if (skin_maximumTrackTintColor) {
        self.sl_maximumTrackTintColor =skin_maximumTrackTintColor;
        [self updateThumbTintColor];
    }
}
- (NSString *)skin_maximumTrackTintColor{
    return self.sl_maximumTrackTintColor;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.sl_thumbTintColor) {
        [self updateThumbTintColor];
    }
    if (self.sl_minimumTrackTintColor) {
        [self updateMinimumTrackTintColor];
    }
    if (self.sl_maximumTrackTintColor) {
        [self updateMaximumTrackTintColor];
    }
}
- (void)updateThumbTintColor{
    self.thumbTintColor =[SLSkinStyleParse colorForKey:self.sl_thumbTintColor];
}
- (void)updateMinimumTrackTintColor{
    self.minimumTrackTintColor =[SLSkinStyleParse colorForKey:self.sl_minimumTrackTintColor];
}
- (void)updateMaximumTrackTintColor{
    self.maximumTrackTintColor =[SLSkinStyleParse colorForKey:self.sl_maximumTrackTintColor];
}
@end

@implementation UISwitch (HBSkin)
static char switchOnTintColorKey,switchThumbTintColorKey;
#pragma mark --private
- (void)setSl_onTintColor:(NSString *)sl_onTintColor{
    objc_setAssociatedObject(self, &switchOnTintColorKey, sl_onTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_onTintColor{
    return objc_getAssociatedObject(self, &switchOnTintColorKey);
}
- (void)setSl_thumbTintColor:(NSString *)sl_thumbTintColor{
    objc_setAssociatedObject(self, &switchThumbTintColorKey, sl_thumbTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_thumbTintColor{
    return objc_getAssociatedObject(self, &switchThumbTintColorKey);
}
#pragma mark --public
- (void)setSkin_onTintColor:(NSString *)skin_onTintColor{
    [self setObserver:self];
    if (skin_onTintColor) {
        self.sl_onTintColor =skin_onTintColor;
        [self updateOnTintColor];
    }
}
- (NSString *)skin_onTintColor{
    return self.sl_onTintColor;
}
- (void)setSkin_thumbTintColor:(NSString *)skin_thumbTintColor{
    [self setObserver:self];
    if (skin_thumbTintColor) {
        self.sl_thumbTintColor =skin_thumbTintColor;
        [self updatethumbTintColor];
    }
}
- (NSString *)skin_thumbTintColor{
    return self.sl_thumbTintColor;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.sl_onTintColor) {
        [self updateOnTintColor];
    }
    if (self.sl_thumbTintColor) {
        [self updatethumbTintColor];
    }
}
- (void)updateOnTintColor{
    self.onTintColor =[SLSkinStyleParse colorForKey:self.sl_onTintColor];
}
- (void)updatethumbTintColor{
    self.thumbTintColor =[SLSkinStyleParse colorForKey:self.sl_thumbTintColor];
}
@end

@implementation UIProgressView (HBSkin)
static char trackTintColorKey,progressTrackTintColorKey;
#pragma mark --private
- (void)setSl_trackTintColor:(NSString *)sl_trackTintColor{
    objc_setAssociatedObject(self, &trackTintColorKey, sl_trackTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_trackTintColor{
    return objc_getAssociatedObject(self, &trackTintColorKey);
}
- (void)setSl_progressTintColor:(NSString *)sl_progressTintColor{
    objc_setAssociatedObject(self, &progressTrackTintColorKey, sl_progressTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_progressTintColor{
    return objc_getAssociatedObject(self, &progressTrackTintColorKey);
}
#pragma mark --public
- (void)setSkin_trackTintColor:(NSString *)skin_trackTintColor{
    [self setObserver:self];
    if (skin_trackTintColor) {
        self.sl_trackTintColor =skin_trackTintColor;
        [self updateTrackTintColor];
    }
}
- (NSString *)skin_trackTintColor{
    return self.sl_trackTintColor;
}
- (void)setSkin_progressTintColor:(NSString *)skin_progressTintColor{
    [self setObserver:self];
    if (skin_progressTintColor) {
        self.sl_progressTintColor =skin_progressTintColor;
        [self updateProgressTintColor];
    }
}
- (NSString *)skin_progressTintColor{
    return self.sl_progressTintColor;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.sl_trackTintColor) {
        [self updateTrackTintColor];
    }
    if (self.sl_progressTintColor) {
        [self updateProgressTintColor];
    }
}
- (void)updateTrackTintColor{
    self.trackTintColor =[SLSkinStyleParse colorForKey:self.sl_trackTintColor];
}
- (void)updateProgressTintColor{
    self.progressTintColor =[SLSkinStyleParse colorForKey:self.sl_progressTintColor];
}
@end

@implementation UIPageControl (HBSkin)
static char pageIndicatorTintColorKey,currentPageIndicatorTintColor;
#pragma mark --private
- (void)setSl_pageIndicatorTintColor:(NSString *)sl_pageIndicatorTintColor{
    objc_setAssociatedObject(self, &pageIndicatorTintColorKey, sl_pageIndicatorTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_pageIndicatorTintColor{
    return objc_getAssociatedObject(self, &pageIndicatorTintColorKey);
}
- (void)setSl_currentPageIndicatorTintColor:(NSString *)sl_currentPageIndicatorTintColor{
    objc_setAssociatedObject(self, &currentPageIndicatorTintColor, sl_currentPageIndicatorTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_currentPageIndicatorTintColor{
    return objc_getAssociatedObject(self, &currentPageIndicatorTintColor);
}
#pragma mark --public
- (void)setSkin_pageIndicatorTintColor:(NSString *)skin_pageIndicatorTintColor{
    [self setObserver:self];
    if (skin_pageIndicatorTintColor) {
        self.sl_pageIndicatorTintColor =skin_pageIndicatorTintColor;
        [self updatePageIndicatorTintColor];
    }
}
- (NSString *)skin_pageIndicatorTintColor{
    return self.sl_pageIndicatorTintColor;
}
- (void)setSkin_currentPageIndicatorTintColor:(NSString *)skin_currentPageIndicatorTintColor{
    [self setObserver:self];
    if (skin_currentPageIndicatorTintColor) {
        self.sl_currentPageIndicatorTintColor =skin_currentPageIndicatorTintColor;
        [self updateCurrentPageIndicatorTintColor];
    }
}
- (NSString *)skin_currentPageIndicatorTintColor{
    return self.sl_currentPageIndicatorTintColor;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.sl_pageIndicatorTintColor) {
        [self updatePageIndicatorTintColor];
    }
    if (self.sl_currentPageIndicatorTintColor) {
        [self updateCurrentPageIndicatorTintColor];
    }
}
- (void)updatePageIndicatorTintColor{
    self.pageIndicatorTintColor =[SLSkinStyleParse colorForKey:self.sl_pageIndicatorTintColor];
}
- (void)updateCurrentPageIndicatorTintColor{
    self.currentPageIndicatorTintColor =[SLSkinStyleParse colorForKey:self.sl_currentPageIndicatorTintColor];
}
@end

@implementation UISearchBar (HBSkin)
static char searchBarTintColor;
#pragma mark --private
- (void)setSl_barTintColor:(NSString *)sl_barTintColor{
    objc_setAssociatedObject(self, &searchBarTintColor, sl_barTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)sl_barTintColor{
    return objc_getAssociatedObject(self, &searchBarTintColor);
}
#pragma mark --public
- (void)setSkin_barTintColor:(NSString *)skin_barTintColor{
    [self setObserver:self];
    if (skin_barTintColor) {
        self.sl_barTintColor =skin_barTintColor;
        [self updateBarTintColor];
    }
}
- (NSString *)skin_barTintColor{
    return self.sl_barTintColor;
}
- (void)updateStyle{
    [super updateStyle];
    if (self.sl_barTintColor) {
        [self updateBarTintColor];
    }
}
- (void)updateBarTintColor{
    self.barTintColor =[SLSkinStyleParse colorForKey:self.sl_barTintColor];
}
@end

@implementation UIBarButtonItem (HBSkin)
@end










