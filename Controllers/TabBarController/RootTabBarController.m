
#import "RootTabBarController.h"
#import "ThemeManager.h"
#import "BaseNavigationController.h"
#import "SwitchThemeController.h"
#import "ViewController.h"

@interface RootTabBarController ()<UITabBarControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation RootTabBarController

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
    SwitchThemeController *controller = [[SwitchThemeController alloc] init];
    [self addChildViewController:controller title:@"社区" image:@"tab_community_n" selectedImage:@"tab_community_s"];
    
    ViewController *shopController = [[ViewController alloc] init];
    [self addChildViewController:shopController title:@"商城" image:@"tab_store_n" selectedImage:@"tab_store_s"];
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
    
    selAttr[NSForegroundColorAttributeName] = kSubColor;
    
    [childVc.tabBarItem setTitleTextAttributes:selAttr forState:UIControlStateSelected];
    BaseNavigationController *navController = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:navController];
}

#pragma mark - tabBarDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    UIViewController *selectedViewController = tabBarController.selectedViewController;
    NSLog(@"selectedIndex=%lu", (unsigned long)tabBarController.selectedIndex);
    if ([viewController isEqual:selectedViewController]) {
        //refresh data
        return NO;
    }
    return YES;
}

@end
