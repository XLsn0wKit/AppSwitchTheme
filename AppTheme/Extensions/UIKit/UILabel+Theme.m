//
//  UILabel+Theme.m
//  VapingTour
//
//  Created by smok on 2017/5/15.
//  Copyright © 2017年 IVPS. All rights reserved.
//

#import "UILabel+Theme.h"
#import "ThemeManager.h"
#import <objc/runtime.h>

@implementation UILabel (Theme)

- (void)th_setTextColor {
    [self th_removeObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangedTextColor) name:KThemeDidChangeNotification object:nil];
    self.textColor = kSubColor;
}

- (void)themeChangedTextColor {
    self.textColor = kSubColor;
}

@end
