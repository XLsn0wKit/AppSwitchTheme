
#import "NSObject+DeallocBlock.h"
#import <objc/runtime.h>

@implementation DeallocBlockExecutor

+ (instancetype)executorWithDeallocBlock:(void (^)(void))deallocBlock {
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

static void *kNSObject_DeallocBlocks;

@implementation NSObject (DeallocBlock)

- (id)addDeallocBlock:(void (^)())deallocBlock {
    if (deallocBlock == nil) {
        return nil;
    }
    
    NSMutableArray *deallocBlocks = objc_getAssociatedObject(self, &kNSObject_DeallocBlocks);
    if (deallocBlocks == nil) {
        deallocBlocks = [NSMutableArray array];
        objc_setAssociatedObject(self, &kNSObject_DeallocBlocks, deallocBlocks, OBJC_ASSOCIATION_RETAIN);
    }
    
    // Check if the block is already existed
    for (DeallocBlockExecutor *executor in deallocBlocks) {
        if (executor.deallocBlock == deallocBlock) {
            return nil;
        }
    }
    
    DeallocBlockExecutor *executor = [DeallocBlockExecutor executorWithDeallocBlock:deallocBlock];
    [deallocBlocks addObject:executor];
    
    return executor;
}

@end
