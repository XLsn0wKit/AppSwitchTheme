//
//  TabBarController.m
//  test
//
//  Created by smok on 16/10/24.
//  Copyright © 2016年 smok. All rights reserved.
//

#import "TabBarController.h"
#import "ViewController.h"
#import "ThemeManager.h"
#import "KNacigationController.h"
#import "SettingViewController.h"

@interface TabBarController ()<UITabBarControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation TabBarController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor: kMainColor]];
    [UITabBar appearance].translucent = NO;
    [self.tabBar th_setTintColor];
    [self addTabBarItem];
    self.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTheme:) name:KThemeDidChangeNotification object:nil];
}

- (void)changeTheme:(NSNotification *)noti {
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:  kMainColor]];
    NSMutableDictionary *selAttr = [NSMutableDictionary dictionary];
    selAttr[NSForegroundColorAttributeName] =  kSubColor;
    [self.tabBar.selectedItem setTitleTextAttributes:selAttr forState:UIControlStateSelected];

}

- (void)addTabBarItem {
    
    SettingViewController *controller = [[SettingViewController alloc] init];
    [self addChildViewController:controller title:@"社区" image:@"tab_community_n" selectedImage:@"tab_community_s"];
    
    UIViewController *shopController = [[UIViewController alloc] init];
    [self addChildViewController:shopController title:@"商城" image:@"tab_store_n" selectedImage:@"tab_store_s"];
    
    UIStoryboard *sb1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *reviewController = [sb1 instantiateInitialViewController];
    [self addChildViewController:reviewController title:NSLocalizedString(@"设置",nil) image:@"tab_message_n" selectedImage:@"tab_message_s"];
    
    UIViewController *meController = [[UIViewController alloc] init];
    [self addChildViewController:meController title:@"我" image:@"tab_reviews_n" selectedImage:@"tab_reviews_s"];
    
}

- (void)addChildViewController:(UIViewController *)childVc  title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selImage {
    childVc.view.backgroundColor = [UIColor whiteColor];
    childVc.title = title;
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    NSMutableDictionary *AttrDic = [NSMutableDictionary dictionary];
    AttrDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [childVc.tabBarItem setTitleTextAttributes:AttrDic forState:UIControlStateNormal];
    NSMutableDictionary *selAttr = [NSMutableDictionary dictionary];
    
    selAttr[NSForegroundColorAttributeName] =  kSubColor;
    
    [childVc.tabBarItem setTitleTextAttributes:selAttr forState:UIControlStateSelected];
    KNacigationController *navController = [[KNacigationController alloc]
                                              initWithRootViewController:childVc];
    [self addChildViewController:navController];
}

#pragma mark - tabBarDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    UIViewController *selectController = tabBarController.selectedViewController;
    if ([viewController isEqual:selectController]) {
        //refresh data
        return NO;
    }
    return YES;
}

@end
