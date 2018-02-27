//
//  ThemeManager.m
//  testHome
//
//  Created by smok on 2017/5/5.
//  Copyright © 2017年 xinyuly. All rights reserved.
//

#import "ThemeManager.h"

#define kThemeNameKey @"kThemeNameKey"

static NSString *ThemeName;

@interface ThemeManager ()

@property (nonatomic, strong) NSMutableDictionary *skinColorsDict;

@end

@implementation ThemeManager

+ (instancetype)sharedInstance {
    static ThemeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ThemeManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if ([super init]) {
        ThemeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeNameKey];
        if (ThemeName == nil) {
            ThemeName = @"Black";
        }
        self.skinColorsDict = [NSMutableDictionary dictionary];
        [self loadSkinColor];
    }
    return self;
}

+ (void)setThemeName:(NSString *)themeName{
    if (themeName != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:themeName forKey:kThemeNameKey];
        ThemeName = themeName;
        [[ThemeManager sharedInstance] loadSkinColor];
        [[NSNotificationCenter defaultCenter] postNotificationName:KThemeDidChangeNotification object:nil];
    }
}

+ (UIColor *)colorWithName:(NSString *)name {
    return [ThemeManager sharedInstance].skinColorsDict[name];
}

- (void)loadSkinColor {
    NSString *colorPlistName = [NSString stringWithFormat:@"SkinColors.plist"];
    NSString *colorPlistPath = [[NSBundle mainBundle] pathForResource:colorPlistName ofType:nil];
    
    NSDictionary *skinDict  = [NSDictionary dictionaryWithContentsOfFile:colorPlistPath];
    NSDictionary *colorDict = skinDict[ThemeName];
    for (NSString *key in colorDict) {
        NSString *colorStr  = colorDict[key];
        UIColor *color = nil;
        if ([colorStr hasPrefix:@"#"]) {
           color = [UIColor colorWithHex:colorStr];
        } else {
            colorStr = [colorStr stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSArray *rgbaStrs = [colorStr componentsSeparatedByString:@","];
            //  转换为RGBA
            CGFloat r = [rgbaStrs[0] doubleValue] / 255.0;
            CGFloat g = [rgbaStrs[1] doubleValue] / 255.0;
            CGFloat b = [rgbaStrs[2] doubleValue] / 255.0;
            CGFloat a = [rgbaStrs[3] doubleValue];
            color = [UIColor colorWithRed:r green:g blue:b  alpha:a];
        }
        self.skinColorsDict[key] = color;
    }

}

@end
