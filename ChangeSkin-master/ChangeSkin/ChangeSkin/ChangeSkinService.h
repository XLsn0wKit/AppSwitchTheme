//
//  ChangeSkinService.h
//  ChangeSkin
//
//  Created by Agenric on 2016/12/12.
//  Copyright © 2016年 Agenric. All rights reserved.
//  APP换肤服务

/*
 说明：
 指定所有换肤的资源图片的统一前缀（cs_）,例原图片为 iconImage 则新图片为 cs_iconImage
 */

#import <Foundation/Foundation.h>

@interface ChangeSkinService : NSObject

// 是否允许更换资源
@property (nonatomic, assign, readonly, getter=isShouldChangeSkin) BOOL shouldChangeSkin;

+ (instancetype)sharedInstance;
- (void)configService;

- (NSString *)resourceFile;
@end
