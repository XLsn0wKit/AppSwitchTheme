//
//  AppDelegate.m
//  MMSkin
//
//  Created by 黄进文 on 2017/2/17.
//  Copyright © 2017年 evenCoder. All rights reserved.
//

#import "AppDelegate.h"
#import "MMTabBarController.h"
#import "NSObject+MMSkinManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    MMTabBarController *skin = [[MMTabBarController alloc] init];
    self.window.rootViewController = skin;
    
    [self.window makeKeyAndVisible];
    
    [self setupGlobalAppearanceColor];
    
    return YES;
}

/** 
 * 设置全局颜色属性 
 */
- (void)setupGlobalAppearanceColor {
    
    // 全局设置UINavigationBar/UITabBar外观属性
    NSString *colorString = [[NSUserDefaults standardUserDefaults] objectForKey:@"MMSkinColor"];
    if (colorString == nil) {
        
        [self mm_setSkinColor:[UIColor orangeColor]];
    }
    else {
        
        NSArray *rgbArr = [colorString componentsSeparatedByString:@" "];
        // 红色
        CGFloat red = [[rgbArr objectAtIndex:1] floatValue];
        CGFloat green = [[rgbArr objectAtIndex:2] floatValue];
        CGFloat blue = [[rgbArr objectAtIndex:3] floatValue];
        CGFloat alpha = [[rgbArr objectAtIndex:4] floatValue];
        UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [self mm_setSkinColor:color];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
