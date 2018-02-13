//
//  MMTabBar.h
//  MMSkin
//
//  Created by 黄进文 on 2017/2/18.
//  Copyright © 2017年 evenCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMTabBar;

@protocol MMTabBarDelegate <UITabBarDelegate>

@optional // 可选

// 点击中间加号代理
- (void)tabBarDidClickAddItem:(MMTabBar *)tabBar;

@end

@interface MMTabBar : UITabBar

@property (nonatomic, weak) id<MMTabBarDelegate> delegate;

+ (instancetype)tabBar;

@end







































