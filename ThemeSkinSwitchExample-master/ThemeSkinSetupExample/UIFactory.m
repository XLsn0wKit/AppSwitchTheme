//
//  UIFactory.m
//  ThemeSkinSetupExample
//
//  Created by Macmini on 16/1/28.
//
//

#import "UIFactory.h"

#import "ThemeTabBarItem.h"
@implementation UIFactory

+ (UITabBarItem *) createTabBarItemWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImageName {
    ThemeTabBarItem * themeTabBarItem = [[ThemeTabBarItem alloc] initWithTitle:title imageName:imageName selectedImage:selectedImageName];
    
    return themeTabBarItem;
}
@end
