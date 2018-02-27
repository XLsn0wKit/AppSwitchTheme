//
//  ThemeManager.h
//  testHome
//
//  Created by smok on 2017/5/5.
//  Copyright © 2017年 xinyuly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+KIAdditions.h"
#import "UIImage+KIAdditions.h"
#import "UIView+Theme.h"
#import "NSObject+DeallocBlock.h"

#define kMainColor       [ThemeManager colorWithName:@"kMainColor"]
#define kSubColor        [ThemeManager colorWithName:@"kSubColor"]
#define kTextColor       [ThemeManager colorWithName:@"kTextColor"]
#define kBackgroundColor [ThemeManager colorWithName:@"kBackgroundColor"]
#define KThemeDidChangeNotification @"KThemeDidChangeNotification"

@interface ThemeManager : NSObject

+ (instancetype)sharedInstance;
+ (void)setThemeName:(NSString *)themeName;
+ (UIColor *)colorWithName:(NSString *)name;

@end
