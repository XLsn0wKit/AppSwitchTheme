//
//  ThemeTabBarItem.h
//  ThemeSkinSetupExample
//
//  Created by Macmini on 16/1/28.
//
//

#import <UIKit/UIKit.h>

@interface ThemeTabBarItem : UITabBarItem

@property (nonatomic, copy) NSString * imageName;
@property (nonatomic, copy) NSString * selectedImageName;


- (id) initWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImageName;

@end
