//
//  BaseViewController.m
//  ThemeSkinSetupExample
//
//  Created by Macmini on 16/1/27.
//
//

#import "BaseViewController.h"

#import "ThemeManager.h"
#import "NotificationMacro.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (id) init {
    if (self == [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangedNotfication:) name:kThemeChangedNotification object:nil];
    }
    
    [self reloadThemeImage];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadThemeImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) themeChangedNotfication:(NSNotification *)notification {
    [self reloadThemeImage];
}

- (void) reloadThemeImage {
    ThemeManager * themeManager = [ThemeManager sharedThemeManager];
    
    UIImage * navigationBackgroundImage = [themeManager themeImageWithName:@"navigationbar_background.png"];
    [self.navigationController.navigationBar setBackgroundImage:navigationBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    UIImage * tabBarBackgroundImage = [themeManager themeImageWithName:@"tabbar_background.png"];
    [self.tabBarController.tabBar setBackgroundImage:tabBarBackgroundImage];
}
@end
