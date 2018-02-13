//
//  NSObject+HBSkinNotify.h
//  HBStockWarning
//
//  Created by Touker on 2017/11/29.
//  Copyright © 2017年 Touker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
//皮肤更新通知
extern NSString * const HBNotificationSkinUpdate;
@interface NSObject (HBSkinNotify)
//添加皮肤更新的观察者
- (void)setObserver:(id)object;
@end
