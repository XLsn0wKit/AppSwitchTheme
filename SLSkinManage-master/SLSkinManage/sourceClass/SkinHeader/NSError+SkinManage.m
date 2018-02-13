//
//  NSError+SkinManage.m
//  AFNetworking
//
//  Created by Touker on 2018/1/31.
//

#import "NSError+SkinManage.h"
HBSkinErrorDomain const HBSKINMANAGEERRORDOMAIN =@"HBSKINMANAGEERRORDOMAIN";
HBSkinErrorDomain const HBSKINDOWNLOADMANAGEERRORDOMAIN =@"HBSKINDOWNLOADMANAGEERRORDOMAIN";
@implementation NSError (SkinManage)
+ (NSError *)SkinErrorWithDomain:(HBSkinErrorDomain)domain code:(NSInteger)code userInfo:(NSDictionary *)dict{
    return [NSError errorWithDomain:domain code:code userInfo:dict];
}
@end
