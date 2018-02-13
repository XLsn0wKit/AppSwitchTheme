//
//  UIFactory.h
//  ThemeSkinSetupExample
//
//  Created by Macmini on 16/1/28.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIFactory : NSObject

+ (UITabBarItem *) createTabBarItemWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImageName;


@end
