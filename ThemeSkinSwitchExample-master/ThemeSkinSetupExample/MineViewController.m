//
//  MineViewController.m
//  ThemeSkinSetupExample
//
//  Created by Macmini on 16/1/27.
//
//

#import "MineViewController.h"

#import "ThemeManager.h"
#import "NotificationMacro.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    
    ThemeManager * themeManager = [ThemeManager sharedThemeManager];
    _themeDataSource = [NSMutableArray arrayWithArray:themeManager.themePlistDict.allKeys];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.themeDataSource.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * Identifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    
    NSString * text = self.themeDataSource[indexPath.row];
    cell.textLabel.text = text;
    
    ThemeManager * themeManager = [ThemeManager sharedThemeManager];
    NSString * currentTheme = themeManager.themeName;
    if (currentTheme == nil) {
        currentTheme = @"默认";
    }
    if ([currentTheme isEqualToString:text]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ThemeManager * themeManager = [ThemeManager sharedThemeManager];
    NSString * themeName = self.themeDataSource[indexPath.row];
    
    if ([themeName isEqualToString:@"默认"]) {
        themeName = nil;
    }
    
    // 记录当前主题名字
    themeManager.themeName = themeName;
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeChangedNotification object:nil];
    
    
    // 主题持久化
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:themeName forKey:kThemeNameKey];
    [userDefaults synchronize];
    
    // 重新加载数据显示UITableViewCellAccessoryCheckmark 显示选中的对号 v
    [self.tableView reloadData];
}

@end
