//
//  OneViewController.m
//  testHome
//
//  Created by smok on 2017/5/8.
//  Copyright © 2017年 xinyuly. All rights reserved.
//

#import "SettingViewController.h"
#import "MeHeaderView.h"
#import "ThemeManager.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *skinList;
@property (nonatomic, strong) MeHeaderView *headerView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, 250);
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.frame = self.view.bounds;
    self.skinList = @[@"Red",@"Blue",@"Black"];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.skinList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.skinList[indexPath.row]];
    [cell.textLabel th_setTextColor];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = self.skinList[indexPath.row];
    [ThemeManager setThemeName:name];
}

#pragma mark - setter && getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (MeHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"MeHeaderView" owner:self options:nil] firstObject];
    }
    return _headerView;
}
@end
