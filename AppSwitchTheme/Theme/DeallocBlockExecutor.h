//
//  DeallocBlockExecutor.h
//  testHome
//
//  Created by smok on 2017/5/8.
//  Copyright © 2017年 xinyuly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeallocBlockExecutor : NSObject

@property (nonatomic, copy) void (^deallocBlock)();

+ (instancetype)executorWithDeallocBlock:(void (^)())deallocBlock;

@end
