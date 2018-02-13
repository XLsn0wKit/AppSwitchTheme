//
//  MMNavigationController.m
//  MMSkin
//
//  Created by 黄进文 on 2017/2/17.
//  Copyright © 2017年 evenCoder. All rights reserved.
//

#import "MMNavigationController.h"
#import "NSObject+MMSkinManager.h"

@interface MMNavigationController ()

@end

@implementation MMNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    
    if (self = [super initWithRootViewController: rootViewController]) {
        
        UINavigationBar *bar = [[UINavigationBar alloc] init];
        // 设置主题颜色
        [bar mm_addToSkinColorPool:@"barTintColor"];
        // 设置属性
        bar.tintColor = [UIColor whiteColor];
        NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0]};
        bar.titleTextAttributes = attributes;
        [self setValue:bar forKey:@"navigationBar"];
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}


@end





























