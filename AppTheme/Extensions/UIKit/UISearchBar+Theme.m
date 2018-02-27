//
//  UISearchBar+Theme.m
//  VapingTour
//
//  Created by smok on 2017/5/15.
//  Copyright © 2017年 IVPS. All rights reserved.
//

#import "UISearchBar+Theme.h"
#import "ThemeManager.h"

@implementation UISearchBar (Theme)

- (void)th_setBackgroundImage {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changedBackgroundImage) name:KThemeDidChangeNotification object:nil];
    [self changedBackgroundImage];
}

- (void)changedBackgroundImage {
    [self setBackgroundImage:[UIImage imageWithColor:kMainColor]];
}

- (void)th_setBarTintColor {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changedBarTintColor) name:KThemeDidChangeNotification object:nil];
    [self changedBarTintColor];
}

- (void)changedBarTintColor {
    [self setBarTintColor:kMainColor];
}

@end
