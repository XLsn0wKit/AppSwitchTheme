//
//  MMTabBar.m
//  MMSkin
//
//  Created by 黄进文 on 2017/2/18.
//  Copyright © 2017年 evenCoder. All rights reserved.
//

#import "MMTabBar.h"
#import "UIView+MMExtension.h"
#import "NSObject+MMSkinManager.h"

#define kControllerCount 4
#define kTabBarHeight 49

@interface MMTabBar()

@property (nonatomic, strong) UIButton *publishButton;

@end

@implementation MMTabBar

static NSString *const bundle = @"MMSkin.bundle/";

@dynamic delegate;

+ (instancetype)tabBar {
    
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        UIButton *publish = [UIButton buttonWithType:UIButtonTypeCustom];
//        [publish setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@%@", bundle, @"tab_publish_nor"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
//        [publish addTarget:self action:@selector(publishDidClick:) forControlEvents:UIControlEventTouchUpInside];
//        self.publishButton = publish;
//        [self addSubview:publish];
        [self mm_addToSkinColorPool:@"tintColor"];
    }
    return self;
}

- (void)publishDidClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickAddItem:)]) {
        
        [self.delegate tabBarDidClickAddItem:self];
    }
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    CGFloat width = self.width / (kControllerCount + 1);
//    self.publishButton.width = width;
//    self.publishButton.height = kTabBarHeight;
//    self.publishButton.x = ([UIScreen mainScreen].bounds.size.width - width) * 0.5;
//    self.publishButton.y = 0;
//    
//    NSInteger index = 0;
//    // 判断是否为控制器按钮
//    for (UIView *tabBarButton in self.subviews) {
//        
//        Class class = NSClassFromString(@"UITabBarButton");
//        if ([tabBarButton.class isSubclassOfClass:class]) {
//            
//            tabBarButton.x = index * width; // 设置除publish按钮位置
//            tabBarButton.width = width;
//            index++;
//            if (index == 2) {
//                
//                index++;
//            }
//        }
//    }
//}

@end




































