//
//  NSObject+MMSkinManager.m
//  MMSkin
//
//  Created by 黄进文 on 2017/2/18.
//  Copyright © 2017年 evenCoder. All rights reserved.
//

#import "NSObject+MMSkinManager.h"

#define MMSkin_COLOR_ARGS_KEY @"MMSkin_COLOR_ARGS_KEY"
#define MMSkin_IMAGE_ARGS_KEY @"MMSkin_IMAGE_ARGS_KEY"

@implementation NSObject (MMSkinManager)

/// 主题颜色池
static NSMutableArray<NSMapTable *> *_skinColorPool;

/// 主题图片池
static NSMutableArray<id> *_skinImagePool;

/// 当前主题颜色
static UIColor *_currentSkinColor;

#pragma mark - lazy
- (NSMutableArray *)skinColorPool {
    
    if (!_skinColorPool) {
        
        _skinColorPool = [NSMutableArray array];
    }
    return _skinColorPool;
}

- (NSMutableArray *)skinImagePool {
    
    if (!_skinImagePool) {
        
        _skinImagePool = [NSMutableArray array];
    }
    return _skinImagePool;
}

#pragma mark - 外部控制方法
- (void)mm_addToSkinColorPoolWithSelector:(SEL)selector objects:(NSArray<id> *)objects {
    
    if (!objects) {
        
        return;
    }
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass]) {
        
        return; // 如果对象为_UIAppearance, 直接返回
    }
    // 键：对象地址+方法名 值：对象
    NSString *pointSelectorString = [NSString stringWithFormat:@"%p%@", self, NSStringFromSelector(selector)];
    // 采用NSMapTable存储对象，使用弱引用
    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableCopyIn valueOptions:NSMapTableWeakMemory];
    [mapTable setObject:self forKey:pointSelectorString];
    [mapTable setObject:objects forKey:MMSkin_COLOR_ARGS_KEY];
    // 判断是否已经在主题色池中
    for (NSMapTable *sub in [[self skinColorPool] copy]) {
        
        if ([[sub description] isEqualToString:[mapTable description]]) {
            
            return;
        }
    }
    // 不存在
    [[self skinColorPool] addObject:mapTable];
    if (_currentSkinColor) { // 已经设置主题色 直接设置
        
        [self mm_performSelector:selector withObjects:objects];
    }
}

- (void)mm_removeFromSkinColorPoolWithSelector:(SEL)selector {
    
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass]) {
        return;
    }
    NSString *pointSelectorString = [NSString stringWithFormat:@"%p%@", self, NSStringFromSelector(selector)];
    // 判断是否已经在主题色池中
    for (NSMapTable *sub in [[self skinColorPool] copy]) {
        
        NSString *object = nil;
        // 获取所有key
        NSEnumerator *enumerator = [sub keyEnumerator];
        NSString *key = nil;
        while (key = [enumerator nextObject]) {
            
            if (![key isEqualToString:MMSkin_COLOR_ARGS_KEY]) {
                
                object = key;
                break;
            }
        }
        if ([object isEqualToString:pointSelectorString]) {
            
            [[self skinColorPool] removeObject:sub];
            return;
        }
    }
}

/// 添加到主题色池
- (void)mm_addToSkinColorPool:(NSString *)propertyName {
    
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass]) {
        return;
    }
    NSString *pointString = [NSString stringWithFormat:@"%p%@", self, propertyName];
    // 采用NSMapTable存储对象，使用弱引用
    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableCopyIn valueOptions:NSMapTableWeakMemory];
    [mapTable setObject:self forKey:pointString];
    for (NSMapTable *subMap in [[self skinColorPool] copy]) {
        
        if ([[subMap description] isEqualToString:[mapTable description]]) {
            
            // 存在 返回
            return;
        }
    }
    // 不存在 保存新的主题池
    [[self skinColorPool] addObject:mapTable];
    if (_currentSkinColor) {
        
        [self setValue:_currentSkinColor forKey:propertyName];
    }
}

/// 从主题色池移除
- (void)mm_removeFromSkinColorPool:(NSString *)propertyName {
    
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass]) {
        return;
    }
    NSString *pointString = [NSString stringWithFormat:@"%p%@", self, propertyName];
    // 判断是否已经在主题色池中
    for (NSMapTable *subMap in [[self skinColorPool] copy]) {
        
        // 获取所有key
        NSEnumerator *enumerator = [subMap keyEnumerator];
        if ([[enumerator nextObject] isEqualToString:pointString]) { // 存在 移除
            
            [[self skinColorPool] removeObject:subMap];
            return;
        }
    }
}

/// 设置主题色
- (void)mm_setSkinColor:(UIColor *)color {
    
    _currentSkinColor = color;
    // 遍历缓存主题池 设置统一颜色
    for (NSMapTable *subMap in [_skinColorPool copy]) {
        // 取出key
        NSString *objectKey = nil;
        NSEnumerator *enumerator = [subMap keyEnumerator];
        NSString *key = nil;
        while (key = [enumerator nextObject]) {
            
            if (![key isEqualToString:MMSkin_COLOR_ARGS_KEY]) {
                
                objectKey = key;
                break;
            }
        }
        if (!key) {
            
            [_skinColorPool removeObject:subMap]; // 如果key为空，则mapTable 为空，移除mapTable
        }
        // 取出对象
        id object = [subMap objectForKey:objectKey];
        if ([objectKey containsString:@":"]) {
            
            // 取出参数
            NSArray *args = [subMap objectForKey:MMSkin_COLOR_ARGS_KEY];
            // 取出方法
            NSString *selectorName = [objectKey substringFromIndex:[[NSString stringWithFormat:@"%p", object] length]];
            SEL selector = NSSelectorFromString(selectorName);
            // 调用方法，设置属性
            [object mm_performSelector:selector withObjects:args];
        }
        else { // 成员属性
            
            NSString *propertyName = [objectKey substringFromIndex:[[NSString stringWithFormat:@"%p", object] length]];
            // KVC设置属性值
            [object setValue:color forKey:propertyName];
        }
    }
}

/// 添加图片主题池
- (void)mm_addToSkinImagePool {
    
    // 如果对象为_UIAppearance，直接返回
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass]) {
        
        return;
    }
    if ([self isKindOfClass:[UITabBarItem class]]) { // 如果是UITabBarItem，判断是否有设置图片
        UITabBarItem *item = (UITabBarItem *)self;
        if (!item.image) { // 没有设置图片
            item.image = [[UIImage alloc] init];
        }
        if (!item.selectedImage) { // 没有设置图片
            item.selectedImage = [[UIImage alloc] init];
        }
    }
    // 判断是否已经在主题图片池中
    if (![[self skinImagePool] containsObject:self]) { // 不在主题图片池中
        
        [[self skinImagePool] addObject:self];
    }
}

/// 从主题图片池中移除
- (void)mm_removeFromSkinImagePool {
    
    Class appearanceClass = NSClassFromString(@"_UIAppearance");
    if ([self isMemberOfClass:appearanceClass]) {
        
        return;
    }
    // 判断是否在图片池中
    if (![[self skinImagePool] containsObject:self]) { // 不在图片池中
        
        [[self skinImagePool] removeObject:self];
    }
}

/// 重新加载主题图片
- (void)mm_reloadSkinImageWithSkinColor:(UIColor *)skinColor setting:(MMSkinImageSettingBlock)block {
    
    // 有主题颜色 设置主题颜色
    if (skinColor) {
        
        [self mm_setSkinColor:skinColor];
    }
    if (block) { // 存在block
        
        block([self skinImagePool]);
    }
}

#pragma mark - 内部控制方法
- (instancetype)mm_performSelector:(SEL)selector withObjects:(const NSArray<id> *)objects {
    
    /// 1.创建方法签名
    NSMethodSignature *methodSignate = [[self class] instanceMethodSignatureForSelector:selector];
    // 判断是否存在
    if (!methodSignate) {
        
        return self;
    }
    /// 2.创建invocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignate];
    /// 3.设置属性
    invocation.target = self;
    invocation.selector = selector;
    NSInteger paramsCount = methodSignate.numberOfArguments - 2; // 获取除self、_cmd的参数个数
    NSInteger count = MIN(paramsCount, objects.count); // 去最少 防止越界
    NSMutableDictionary *objCopy = nil;
    // 设置参数
    for (int i = 0; i < count; i++) {
        // 取出参数对象
        id obj = objects[i];
        // 如果是主题颜色参数颜色，则设置
        if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:MMSkinColor]) {
            obj = _currentSkinColor;
        }
        // 判断需要设置的参数是否是NSNull, 如果是就设置为nil
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = nil;
        }
        // 获取参数类型
        const char *argumentType = [methodSignate getArgumentTypeAtIndex:i + 2];
        // 判断参数类型 根据类型转化数据类型（如果有必要）
        NSString *argumentTypeString = [NSString stringWithUTF8String:argumentType];
        if ([argumentTypeString isEqualToString:@"@"]) { // id
            // 如果是dictionary，可能存在 PYTHEME_THEME_COLOR
            if ([obj isKindOfClass:[NSDictionary class]]) { // NSDictionary
                objCopy = [obj mutableCopy];
                // 取出所有键
                NSArray *keys = [objCopy allKeys];
                for (NSString *key in keys) {
                    // 取出值
                    id value = objCopy[key];
                    if ([value isKindOfClass:[NSString class]] && [value isEqualToString:MMSkinColor]) {
                        // 替换成颜色
                        [objCopy setValue:_currentSkinColor forKey:key];
                    }
                }
                [invocation setArgument:&objCopy atIndex:i + 2];
            } else { // 其他
                [invocation setArgument:&obj atIndex:i + 2];
            }
        }  else if ([argumentTypeString isEqualToString:@"B"]) { // bool
            
            bool objVaule = [obj boolValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"f"]) { // float
            
            float objVaule = [obj floatValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"d"]) { // double
            
            double objVaule = [obj doubleValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"c"]) { // char
            
            char objVaule = [obj charValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"i"]) { // int
            
            int objVaule = [obj intValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"I"]) { // unsigned int
            
            unsigned int objVaule = [obj unsignedIntValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"S"]) { // unsigned short
            
            unsigned short objVaule = [obj unsignedShortValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"L"]) { // unsigned long
            
            unsigned long objVaule = [obj unsignedLongValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"s"]) { // shrot
            
            short objVaule = [obj shortValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"l"]) { // long
            
            long objVaule = [obj longValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"q"]) { // long long
            
            long long objVaule = [obj longLongValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"C"]) { // unsigned char
            
            unsigned char objVaule = [obj unsignedCharValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"Q"]) { // unsigned long long
            
            unsigned long long objVaule = [obj unsignedLongLongValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"{CGRect={CGPoint=dd}{CGSize=dd}}"]) { // CGRect
            
            CGRect objVaule = [obj CGRectValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        } else if ([argumentTypeString isEqualToString:@"{UIEdgeInsets=dddd}"]) { // UIEdgeInsets
            
            UIEdgeInsets objVaule = [obj UIEdgeInsetsValue];
            [invocation setArgument:&objVaule atIndex:i + 2];
        }
    }
    /// 4.调用方法
    [invocation invoke];
    id returnValue = nil;
    if (methodSignate.methodReturnLength != 0) { // 返回值
        
        [invocation getReturnValue:&returnValue];
    }
    return returnValue;
}

@end
