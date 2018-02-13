//
//  SLNextViewController.m
//  SLSkinManage_Example
//
//  Created by Touker on 2018/2/5.
//  Copyright © 2018年 lishuailibertine. All rights reserved.
//

#import "SLNextViewController.h"
#import <SLSkinManage/SLSkin.h>

@interface SLNextViewController ()

@end

@implementation SLNextViewController

+ (id)createNextViewController;
{
    SLNextViewController * rootViewController =[SLNextViewController createFromStoryboardWithStoryboardID:@"SLNextViewController" storyboardName:@"SLNextViewController" bundleName:nil];
    return rootViewController;
}
+ (instancetype)createFromStoryboardWithStoryboardID:(NSString *)aStoryboardID storyboardName:(NSString *)aStoryboardName  bundleName:(NSString *)aBundleName {
    NSBundle *bundle = [self getBundleWithBundleName:aBundleName];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:aStoryboardName bundle:bundle];
    return [storyboard instantiateViewControllerWithIdentifier:aStoryboardID];
}

+ (NSBundle *)getBundleWithBundleName:(NSString *)aBundleName {
    NSBundle *bundle = [NSBundle mainBundle];
    if (aBundleName.length) {
        bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:aBundleName withExtension:@"bundle"]];
    }
    return bundle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.skin_barBackground_image=@"pic1";
    // Do any additional setup after loading the view.
}
@end
