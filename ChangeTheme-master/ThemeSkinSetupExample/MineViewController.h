//
//  MineViewController.h
//  ThemeSkinSetupExample
//
//  Created by Macmini on 16/1/27.
//
//

#import "BaseViewController.h"

@interface MineViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSMutableArray * themeDataSource;
@end
