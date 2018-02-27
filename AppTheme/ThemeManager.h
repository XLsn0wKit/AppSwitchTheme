
#import <UIKit/UIKit.h>
#import "ExtensionsHeader.h"

#define kMainColor       [ThemeManager colorWithName:@"kMainColor"]
#define kSubColor        [ThemeManager colorWithName:@"kSubColor"]
#define kTextColor       [ThemeManager colorWithName:@"kTextColor"]
#define kBackgroundColor [ThemeManager colorWithName:@"kBackgroundColor"]
#define KThemeDidChangeNotification @"KThemeDidChangeNotification"

@interface ThemeManager : NSObject

+ (instancetype)sharedInstance;
+ (void)setThemeName:(NSString *)themeName;
+ (UIColor *)colorWithName:(NSString *)name;

@end
