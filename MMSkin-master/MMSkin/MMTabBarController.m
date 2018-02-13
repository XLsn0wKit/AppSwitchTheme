//
//  MMTabBarController.m
//  MMSkin
//
//  Created by 黄进文 on 2017/2/17.
//  Copyright © 2017年 evenCoder. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "MMTabBarController.h"
#import "MMSkinViewController.h"
#import "MMNavigationController.h"
#import "MMPublishViewController.h"
#import "MMTabBar.h"
#import "MMShineManager.h"

#define MMColor(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

#define MMRandomColor MMColor(arc4random_uniform(254),arc4random_uniform(254),arc4random_uniform(254))

@interface MMTabBarController ()

@property (nonatomic, assign) NSInteger indexFlag;

@property (nonatomic, assign) SystemSoundID clickSound;

@end

@implementation MMTabBarController

static NSString *const bundle = @"MMSkin.bundle/";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 自定义tabBar
    MMTabBar *tabBar = [MMTabBar tabBar];
    [self setValue:tabBar forKey:@"tabBar"];
    [self setupChildViewControllers];
}

#pragma mark - 添加子控制器
- (void)setupChildViewControllers {
    
    [self addChildViewControllers:[[MMSkinViewController alloc] init] image:@"tab_home_nor" selectedImage:@"tab_home_press" title:@"首页"];
    [self addChildViewControllers:[[MMSkinViewController alloc] init] image:@"tab_classify_nor" selectedImage:@"tab_classify_press" title:@"分类"];
    [self addChildViewControllers:[[MMSkinViewController alloc] init] image:@"tab_community_nor" selectedImage:@"tab_community_press" title:@"社区"];
    [self addChildViewControllers:[[MMSkinViewController alloc] init] image:@"tab_me_nor" selectedImage:@"tab_me_nor" title:@"我的"];
}

- (void)addChildViewControllers:(UIViewController *)childController image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    
    childController.title = title;
    NSString *imageStr = [NSString stringWithFormat:@"%@%@", bundle, image];
    [childController.tabBarItem setImage:[[UIImage imageNamed:imageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    NSString *imageSelect = [NSString stringWithFormat:@"%@%@", bundle, selectedImage];
    [childController.tabBarItem setSelectedImage:[[UIImage imageNamed:imageSelect] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    // 导航条
    MMNavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}

/// push publish控制器
- (void)tabBarDidClickAddItem:(MMTabBar *)tabBar {
    
    [self presentViewController:[[MMPublishViewController alloc] init] animated:YES completion:nil];
}

#pragma mark - TabBar Delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (self.indexFlag != index) {
        
        [self animationWithIndex:index];
        [self clickTabBarForAudio];
    }
}

/// 执行动画
- (void)animationWithIndex: (NSInteger)index {
    
    NSMutableArray *tabBarButtons = [NSMutableArray array];
    // 判断是否为控制器按钮
    for (UIView *tabBarButton in self.tabBar.subviews) {
        
        Class class = NSClassFromString(@"UITabBarButton");
        if ([tabBarButton.class isSubclassOfClass:class]) {
            
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIView *tabBarButton = tabBarButtons[index];
    self.indexFlag = index;
    
    [[MMShineManager shareInstance] shineWithChildView:tabBarButton rootView:self.tabBar fillColor:MMRandomColor];
}

#pragma mark - 点击tabBar音效
- (void)clickTabBarForAudio {
    
    NSString *clickSoundPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%@", bundle, @"click"] ofType:@"caf"];
    NSURL *clickSoundURL = [NSURL fileURLWithPath:clickSoundPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(clickSoundURL), &_clickSound);
    AudioServicesPlaySystemSound(self.clickSound);
}

/// 暂时不用
- (void)startAnimationWithTabBarButtons:(UIView *)tabBarButton {
    
    CABasicAnimation *heart = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    heart.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    heart.duration = 0.05;
    heart.repeatCount = 2;
    heart.autoreverses = YES;
    heart.fromValue = [NSNumber numberWithFloat:0.6];
    heart.toValue = [NSNumber numberWithFloat:1.2];
    
    [[tabBarButton layer] addAnimation:heart forKey:nil];
}

@end











































