//
//  UIImage+ChangeSkin.m
//  ChangeSkin
//
//  Created by Agenric on 2016/12/12.
//  Copyright © 2016年 Agenric. All rights reserved.
//

#import "UIImage+ChangeSkin.h"
#import <objc/runtime.h>
#import "ChangeSkinService.h"

@implementation UIImage (ChangeSkin)

+ (void)load {
    Method origImageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    method_exchangeImplementations(origImageNamedMethod, class_getClassMethod(self, @selector(changeSkin_imageNamed:)));
}

+ (nullable UIImage *)changeSkin_imageNamed:(NSString *)name {
    if ([ChangeSkinService sharedInstance].isShouldChangeSkin) {
        NSString *path=[[[ChangeSkinService sharedInstance] resourceFile] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.png",name]];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        return image != nil ? image : [UIImage changeSkin_imageNamed:name];
    } else {
        return [UIImage changeSkin_imageNamed:name];
    }
}

@end
