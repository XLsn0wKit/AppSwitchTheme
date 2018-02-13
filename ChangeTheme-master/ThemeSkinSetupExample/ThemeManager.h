//
//  ThemeManager.h
//  ThemeSkinSetupExample
//
//  Created by Macmini on 16/1/27.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ThemeManager : NSObject

@property (nonatomic, copy) NSString * themeName;           // 主题名字
@property (nonatomic, retain) NSDictionary * themePlistDict;    // 主题属性列表字典

+ (ThemeManager *) sharedThemeManager;

- (UIImage *) themeImageWithName:(NSString *)imageName;
@end
