//
//  UIColor+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 12-10-24.
//
//

#import "UIColor+KIAdditions.h"

@implementation UIColor (KIAdditions)

+ (UIColor *)colorWithHex:(NSString *)hex {
    if (hex == nil) {
        return nil;
    }
    if ([hex hasPrefix:@"#"]) {
        hex = [hex substringFromIndex:1];
    }
    hex = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    NSUInteger length = hex.length;
    
    if (length < 3) {
        return nil;
    }
    
    unsigned int r, g, b, a=1.0f;
    a = 255;
    
    int step = length>=6?2:1;
    int start = 0;
    
    [UIColor scann:&r from:hex range:NSMakeRange(start, step)];
    start += step;
    [UIColor scann:&g from:hex range:NSMakeRange(start, step)];
    start += step;
    [UIColor scann:&b from:hex range:NSMakeRange(start, step)];
    
    if (length == 4 || length == 8) {
        start += step;
        [UIColor scann:&a from:hex range:NSMakeRange(start, step)];
    }
    
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}

+ (void)scann:(unsigned int *)value from:(NSString *)from range:(NSRange)range {
    NSString *temp = [from substringWithRange:range];
    if (range.length == 1) {
        temp = [NSString stringWithFormat:@"%@%@", temp, temp];
    }
    [[NSScanner scannerWithString:temp] scanHexInt:value];
}

- (void)colorComponents:(CGFloat[4])components {
    if (self != nil) {
        size_t numberOfColorComponents = CGColorGetNumberOfComponents(self.CGColor);
        const CGFloat *colorComponents = CGColorGetComponents(self.CGColor);
        
        if (numberOfColorComponents == 2) {
            components[0] = colorComponents[0];
            components[1] = colorComponents[0];
            components[2] = colorComponents[0];
            components[3] = colorComponents[1];
        } else {
            components[0] = colorComponents[0];
            components[1] = colorComponents[1];
            components[2] = colorComponents[2];
            components[3] = colorComponents[3];
        }
    }
}

- (NSString *)hexString {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

@end
