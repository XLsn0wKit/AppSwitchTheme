//
//  NSObject+HBSkinKit.h
//  AFNetworking
//
//  Created by Touker on 2018/2/5.
//

#import <Foundation/Foundation.h>
@interface UIView (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_background_color;
@end
@interface UIButton (HBSkin)
- (void)skin_titleColor:(NSString *)type forState:(UIControlState)state;
- (void)skin_imageNamed:(NSString *)name forState:(UIControlState)state;
- (void)skin_backgroundImageNamed:(NSString *)name forState:(UIControlState)state;
@end

@interface UIImageView (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_image;
@end

@interface UILabel (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_title_color;
@end

@interface UINavigationBar (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_barBackground_image;
@property (copy,nonatomic) IBInspectable NSString *skin_barBackground_color;
@end

@interface UITabBarItem (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_image_name;
@property (copy,nonatomic) IBInspectable NSString *skin_selectedImage_name;
@end

@interface UITextField (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_textFont;
@property (copy,nonatomic) IBInspectable NSString *skin_textColor;
@end

@interface UITextView (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_textFont;
@property (copy,nonatomic) IBInspectable NSString *skin_textColor;
@end

@interface UISlider (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_thumbTintColor;
@property (copy,nonatomic) IBInspectable NSString *skin_minimumTrackTintColor;
@property (copy,nonatomic) IBInspectable NSString *skin_maximumTrackTintColor;
@end

@interface UISwitch (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_onTintColor;
@property (copy,nonatomic) IBInspectable NSString *skin_thumbTintColor;
@end

@interface UIProgressView (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_trackTintColor;
@property (copy,nonatomic) IBInspectable NSString *skin_progressTintColor;
@end

@interface UIPageControl (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_pageIndicatorTintColor;
@property (copy,nonatomic) IBInspectable NSString *skin_currentPageIndicatorTintColor;
@end

@interface UISearchBar (HBSkin)
@property (copy,nonatomic) IBInspectable NSString *skin_barTintColor;
@end

@interface UIBarButtonItem (HBSkin)
@end
