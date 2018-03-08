//
//  UIView+MMExtension.h
//  MMSkin
//
//  Created by 黄进文 on 2017/2/17.
//  Copyright © 2017年 evenCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MMExtension)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;

/** 从xib中创建一个工具条 */
+ (instancetype)viewFromXib;

@end
