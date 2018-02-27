//
//  UIButton+Theme.m
//  VapingTour
//
//  Created by smok on 2017/5/15.
//  Copyright © 2017年 IVPS. All rights reserved.
//

#import "UIButton+Theme.h"
#import <objc/runtime.h>
#import "ThemeManager.h"

@implementation UIButton (Theme)

- (void)th_setTitleColorWithStateSelected{
    [self th_removeObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangedTitleColorSelected) name:KThemeDidChangeNotification object:nil];
    [self setTitleColor:kSubColor forState:UIControlStateSelected];
}

- (void)themeChangedTitleColorSelected {
    [self setTitleColor:kSubColor forState:UIControlStateSelected];
}

- (void)th_setTitleColorWithStateNormal{
    [self th_removeObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangedTitleColorNormal) name:KThemeDidChangeNotification object:nil];
    [self setTitleColor:kSubColor forState:UIControlStateNormal];
}

- (void)themeChangedTitleColorNormal {
    [self setTitleColor:kSubColor forState:UIControlStateNormal];
}
@end
