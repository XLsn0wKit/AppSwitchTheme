//
//  NSObject+DeallocBlock.h
//  testHome
//
//  Created by smok on 2017/5/8.
//  Copyright © 2017年 xinyuly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DeallocBlock)

- (id)addDeallocBlock:(void (^)())deallocBlock;

@end
