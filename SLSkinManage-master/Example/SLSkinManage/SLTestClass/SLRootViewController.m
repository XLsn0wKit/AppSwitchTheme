//
//  SLRootViewController.m
//  SLSkinManage_Example
//
//  Created by Touker on 2018/2/2.
//  Copyright © 2018年 lishuailibertine. All rights reserved.
//

#import "SLRootViewController.h"
#import <SLSkinManage/SLSkin.h>
#import "SLNextViewController.h"

@interface SLTableViewCell:UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *skinImageView;
@end
@implementation SLTableViewCell
@end

@interface SLRootViewController ()
@property (weak, nonatomic) IBOutlet UITableView *skinTableView;

@end

@implementation SLRootViewController
+ (id)createRootViewController
{
    SLRootViewController * rootViewController =[SLRootViewController createFromStoryboardWithStoryboardID:@"SLRootViewController" storyboardName:@"SLRootViewController" bundleName:nil];
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
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width = -2;
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(0, 0, 50, 30);
    [editBtn setTitle:@"换肤" forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [editBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,item0];
    self.view.backgroundColor =[UIColor grayColor];
    self.navigationController.navigationBar.skin_barBackground_image=@"pic1";
    self.skinTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}
- (void)btnClick:(UIControl*)btn{
    btn.selected=!btn.selected;
    NSString * bundleID =btn.selected?@"SkinStyle_Night":@"SkinStyle_Light";
    SLSwitchSkinByBundleID(bundleID);
}
#pragma mark -
#pragma mark -代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"SLTableViewCell"];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
#pragma mark -行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
#pragma mark -区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLNextViewController * nextController =[SLNextViewController createNextViewController];
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
