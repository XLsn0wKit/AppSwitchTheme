//
//  MainViewController.m
//  ThemeSkinSetupExample
//
//  Created by Macmini on 16/1/27.
//
//

#import "MainViewController.h"

#import "HomeViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"

#import "UIFactory.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (id) init {
    if (self = [super init]) {
        [self initTabBarUI];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSLog(@"xxx0000");
    
    //NSLog(@"更改了一些东西");
    
    
    //AAAAAAAAAAAAAAPPPPPPPPPPPPP
    
    
    
    
    //PPPPPPPPPPOOOOOOOOOOOO
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    //打印一下子 ~~~~~~
    
    
    
    //打印第二下
    
    
    //我曹  打印第三下
    
    
    //我曹  打印地四下
}


- (void) initTabBarUI {
    // 主页
    HomeViewController * homeViewController = [[HomeViewController alloc] init];
    UINavigationController * homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
//    UITabBarItem * homeTabBarItem = [[UITabBarItem alloc] initWithTitle:@"主页" image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected"]];
    UITabBarItem * homeTabBarItem = [UIFactory createTabBarItemWithTitle:@"主页" imageName:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    homeNavigationController.tabBarItem = homeTabBarItem;
    
    // 消息（中心）
    MessageViewController * messageViewController = [[MessageViewController alloc] init];
    UINavigationController * messageNavigationController = [[UINavigationController alloc] initWithRootViewController:messageViewController];
//    UITabBarItem * messageTabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageNamed:@"tabbar_message_center_selected"]];
    UITabBarItem * messageTabBarItem = [UIFactory createTabBarItemWithTitle:@"消息" imageName:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    messageNavigationController.tabBarItem = messageTabBarItem;
    
    // 我
    MineViewController * mineViewController = [[MineViewController alloc] init];
    UINavigationController * mineNavigationController = [[UINavigationController alloc] initWithRootViewController:mineViewController];
//    UITabBarItem * mineTabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageNamed:@"tabbar_profile_selected"]];
    UITabBarItem * mineTabBarItem = [UIFactory createTabBarItemWithTitle:@"我" imageName:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    
    mineNavigationController.tabBarItem = mineTabBarItem;
    NSArray * viewControllers = @[homeNavigationController, messageNavigationController, mineNavigationController];
    self.viewControllers = viewControllers;
}


- (void)themeChangedNotification:(NSNotification *)notification {
    

}
@end
