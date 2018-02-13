//
//  ThemeTabBarItem.m
//  ThemeSkinSetupExample
//
//  Created by Macmini on 16/1/28.
//
//

#import "ThemeTabBarItem.h"
#import "ThemeManager.h"
#import "NotificationMacro.h"

@implementation ThemeTabBarItem

// 初始化时注册观察者
- (id) init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangedNotification:) name:kThemeChangedNotification object:nil];
    }
    
    return self;
}

- (id) initWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImageName {
    if (self = [self init]) {
        self.title = title;
        self.imageName = imageName;         // 此时会调用[self setImageName:imageName] ---> [self reloadThemeImage] --->[self setImage:image]
        self.selectedImageName = selectedImageName;// 此时会调用[self setSelectedImageName:selectedImageName];
    }
    
    return self;
}


#pragma mark -
#pragma mark - Override Setter
- (void) setImageName:(NSString *)imageName {
    if (_imageName != imageName) {
        _imageName = imageName;
    }
    
    [self reloadThemeImage];
}

- (void) setSelectedImageName:(NSString *)selectedImageName {
    if (_selectedImageName != selectedImageName) {
        _selectedImageName = selectedImageName;
    }
    
    [self reloadThemeImage];
}



// 主题改变之后重新加载图片
- (void)themeChangedNotification:(NSNotification *)notification {
    [self reloadThemeImage];
}

- (void)reloadThemeImage {
    ThemeManager * themeManager = [ThemeManager sharedThemeManager];
    
    if (self.imageName != nil) {
        UIImage * image = [themeManager themeImageWithName:self.imageName];
        [self setImage:image];
    }
    
    if (self.selectedImageName != nil) {
        UIImage * selectedImage = [themeManager themeImageWithName:self.selectedImageName];
        [self setSelectedImage:selectedImage];
    }
}




- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
