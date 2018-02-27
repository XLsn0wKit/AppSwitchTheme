
#import "BaseNavigationController.h"
#import "ThemeManager.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    
    if (self = [super initWithRootViewController:rootViewController]) {
        UIColor *color = kMainColor;
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.tintColor = [UIColor whiteColor];
        NSDictionary *attributes = @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                      NSFontAttributeName: [UIFont boldSystemFontOfSize:20]};
        self.navigationBar.titleTextAttributes = attributes;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTheme:) name:KThemeDidChangeNotification object:nil];
    }
    return self;
}

- (void)changeTheme:(NSNotification *)noti {
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:kMainColor] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
#pragma mark - 设置状态栏白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
