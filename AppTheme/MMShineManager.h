//
//  MMShineManager.h
//  MMSkin
//
//  Created by 黄进文 on 2017/2/19.
//  Copyright © 2017年 evenCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMShineManager : NSObject

+ (MMShineManager *)shareInstance;

- (void)shineWithChildView:(UIView *)childView
                  rootView:(UIView *)rootView
                 fillColor:(UIColor *)fillColor;

@end
