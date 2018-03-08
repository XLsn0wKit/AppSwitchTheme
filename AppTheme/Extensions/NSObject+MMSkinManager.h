//
//  NSObject+MMSkinManager.h
//  MMSkin
//
//  Created by 黄进文 on 2017/2/18.
//  Copyright © 2017年 evenCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

// 主题色Key
#define MMSkinColor @"MMSkinColor"

// 设置肤色调用的Block
typedef void (^MMSkinImageSettingBlock)(const NSArray<id> *objects);

@interface NSObject (MMSkinManager)

/**
 * 添加到主题色池
 * selector : 执行方法
 * objects : 方法参数数组
 * 注意：方法参数必须按顺序一一对应，如果涉及到的主题色设置使用 YYTHEME_THEME_COLOR 宏定义代替
 * 如果数组中某个参数为nil，需包装为 [NSNull null] 对象再添加到数组中
 */
- (void)mm_addToSkinColorPoolWithSelector:(SEL)selector objects:(NSArray<id> *)objects;

/**
 * 从主题色池移除
 * selector : 执行方法
 */
- (void)mm_removeFromSkinColorPoolWithSelector:(SEL)selector;

/**
 * 添加到主题色池
 * propertyName : 属性名
 */
- (void)mm_addToSkinColorPool:(NSString *)propertyName;

/**
 * 从主题色池移除
 * propertyName : 属性名
 */
- (void)mm_removeFromSkinColorPool:(NSString *)propertyName;

/**
 * 设置主题色
 * color : 主题色
 */
- (void)mm_setSkinColor:(UIColor *)color;

/**
 * 添加到主题图片池
 */
- (void)mm_addToSkinImagePool;

/**
 * 从主题图片池中移除
 */
- (void)mm_removeFromSkinImagePool;

/**
 * 重新加载主题图片
 * themeColor : 主题色
 * block : 设置主题图片时调用的block
 */
- (void)mm_reloadSkinImageWithSkinColor:(UIColor *)skinColor setting:(MMSkinImageSettingBlock)block;

@end





















