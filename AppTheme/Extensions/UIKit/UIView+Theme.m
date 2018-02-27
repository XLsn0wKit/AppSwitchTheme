//
//  UIView+Theme.m
//  testHome
//
//  Created by smok on 2017/5/8.
//  Copyright © 2017年 xinyuly. All rights reserved.
//

#import "UIView+Theme.h"
#import <objc/runtime.h>
#import "ThemeManager.h"

static void *kViewDeallocHelper;

@implementation UIView (Theme)

- (void)th_removeObserver {
    if (objc_getAssociatedObject(self, &kViewDeallocHelper) == nil) {
        __weak typeof(self) weakSelf = self;
        id deallocHelper = [self addDeallocBlock:^{
            [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
        }];
        objc_setAssociatedObject(self, &kViewDeallocHelper, deallocHelper, OBJC_ASSOCIATION_ASSIGN);
    }
}

#pragma mark - setter && getter
- (void)th_setBackgroundColor {
    [self th_removeObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangedBackgroundColor) name:KThemeDidChangeNotification object:nil];
    [self setBackgroundColor:kSubColor];
}

- (void)themeChangedBackgroundColor {
    [self setBackgroundColor:kSubColor];
}

- (void)th_setTintColor {
    [self th_removeObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangedTintColor) name:KThemeDidChangeNotification object:nil];
    [self setTintColor:kSubColor];
}

- (void)themeChangedTintColor {
    [self setTintColor:kSubColor];
}

@end
