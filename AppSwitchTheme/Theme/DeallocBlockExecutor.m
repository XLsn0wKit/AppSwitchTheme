//
//  DeallocBlockExecutor.m
//  testHome
//
//  Created by smok on 2017/5/8.
//  Copyright © 2017年 xinyuly. All rights reserved.
//

#import "DeallocBlockExecutor.h"

@implementation DeallocBlockExecutor

+ (instancetype)executorWithDeallocBlock:(void (^)())deallocBlock {
    DeallocBlockExecutor *exe = [DeallocBlockExecutor new];
    exe.deallocBlock = deallocBlock;
    return exe;
}

- (void)dealloc {
    if (self.deallocBlock) {
        self.deallocBlock();
        self.deallocBlock = nil;
    }
}

@end
