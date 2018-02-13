//
//  SLSkinStyleParse.h
//  AFNetworking
//
//  Created by Touker on 2018/2/1.
//

#import <Foundation/Foundation.h>

@interface SLSkinStyleParse : NSObject
/**
 * 根据样式配置表中colors对应的key获取color对象
 */
+ (UIColor *)colorForKey:(NSString *)key;
/**
 * 根据样式配置表中Fonts对应的key获取font对象
 */
+ (UIFont *)fontForKey:(NSString *)key;
/**
 * 根据样式配置表中Images对应的key获取image对象
 */
+ (UIImage *)imageForKey:(NSString *)key;

+ (id)otherForType:(NSString *)type;
@end

@interface UIImage (SLSkin)
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
