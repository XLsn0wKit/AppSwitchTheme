//
//  SLSkinStyleParse.m
//  AFNetworking
//
//  Created by Touker on 2018/2/1.
//

#import "SLSkinStyleParse.h"
#import "SLSkinManage.h"
@interface UIColor (SLSkin)
+ (UIColor *)colorWithHexString:(NSString *)hexString;
@end

@interface UIFont (SLSkin)
@end

@implementation SLSkinStyleParse
#pragma mark --public
+ (UIColor *)colorForKey:(NSString *)key{
    if (key) {
        NSString *hexString = [[SLSkinManage sharedSkinManage].currentConfigMap[kSkinConfigColorForKey] valueForKey:key];
        NSInteger lenth = hexString.length;
        switch (lenth) {
            case 3:
            case 4:
            case 6:
            case 8:
                return [UIColor colorWithHexString:hexString];
                break;
            default:
                return [UIColor clearColor];
                break;
        }
    } else {
        return [UIColor clearColor];
    }
}

+ (UIFont *)fontForKey:(NSString *)key{
    if (key) {
        NSString *hexString = [[SLSkinManage sharedSkinManage].currentConfigMap[kSkinConfigFontForKey] valueForKey:key];
        if (hexString) {
            return [UIFont systemFontOfSize:hexString.floatValue];
        } else {
            return [UIFont systemFontOfSize:14];
        }
    } else {
        return [UIFont systemFontOfSize:14];
    }
}

+ (UIImage *)imageForKey:(NSString *)key{
    UIImage *image;
    if (key) {
        NSDictionary *configMap_image = [SLSkinManage sharedSkinManage].currentConfigMap[kSkinConfigImageForKey];
        NSString * currentBundleID = [SLSkinManage sharedSkinManage].currentBundleID;
        NSString * imageName =[configMap_image valueForKey:key];
        //先在工程中找bundle
        NSBundle * sourcesBundle = [SLSkinManage getBundleWithBundleName:currentBundleID];
        if (sourcesBundle==nil) {
            sourcesBundle = [SLSkinManage getBundleInSandboxWithBundleName:currentBundleID directoryType:HBSkinDownloadDirectory inDirectory:HBSkinDownloadSubDirectory];
        }
        if (sourcesBundle==nil) {
            NSLog(@"`imageForKey` about bundle not found ");
            return nil;
        }else{
            NSString * imagePath = [SLSkinManage getImagePathWithBundle:sourcesBundle imageName:imageName imageType:HBImageTypeKey inDirectory:HBImageSubpathKey];
            if (imagePath==nil) {
                NSLog(@"`imageForKey` about imagePath not found ");
            }
            image =[UIImage imageWithContentsOfFile:imagePath];
        }
    }
    return image;
}

+ (id)otherForType:(NSString *)type{
    
    return nil;
}
#pragma mark --private
@end

@implementation UIColor (SLSkin)
+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@end

@implementation UIFont (SLSkin)
@end

@implementation UIImage (SLSkin)
+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
@end
/*
 十六进制透明度
 100% — FF
 99% — FC
 98% — FA
 97% — F7
 96% — F5
 95% — F2
 94% — F0
 93% — ED
 92% — EB
 91% — E8
 90% — E6
 89% — E3
 88% — E0
 87% — DE
 86% — DB
 85% — D9
 84% — D6
 83% — D4
 82% — D1
 81% — CF
 80% — CC
 79% — C9
 78% — C7
 77% — C4
 76% — C2
 75% — BF
 74% — BD
 73% — BA
 72% — B8
 71% — B5
 70% — B3
 69% — B0
 68% — AD
 67% — AB
 66% — A8
 65% — A6
 64% — A3
 63% — A1
 62% — 9E
 61% — 9C
 60% — 99
 59% — 96
 58% — 94
 57% — 91
 56% — 8F
 55% — 8C
 54% — 8A
 53% — 87
 52% — 85
 51% — 82
 50% — 80
 49% — 7D
 48% — 7A
 47% — 78
 46% — 75
 45% — 73
 44% — 70
 43% — 6E
 42% — 6B
 41% — 69
 40% — 66
 39% — 63
 38% — 61
 37% — 5E
 36% — 5C
 35% — 59
 34% — 57
 33% — 54
 32% — 52
 31% — 4F
 30% — 4D
 29% — 4A
 28% — 47
 27% — 45
 26% — 42
 25% — 40
 24% — 3D
 23% — 3B
 22% — 38
 21% — 36
 20% — 33
 19% — 30
 18% — 2E
 17% — 2B
 16% — 29
 15% — 26
 14% — 24
 13% — 21
 12% — 1F
 11% — 1C
 10% — 1A
 9% — 17
 8% — 14
 7% — 12
 6% — 0F
 5% — 0D
 4% — 0A
 3% — 08
 2% — 05
 1% — 03
 0% — 00
 */
