//
//  UIColor+CTH.m
//

#import "UIColor+CTH.h"

@implementation UIColor (CTHColor)

+ (instancetype)cth_colorWithHex:(NSInteger)rgb
{
    return [UIColor cth_colorWithHex:rgb alpha:1.f];
}

+ (instancetype)cth_colorWithHex:(NSInteger)rgb alpha:(CGFloat)alpha
{
    CGFloat red = ((float) ((rgb & 0xFF0000) >> 16)) / 255.f;
    CGFloat green = ((float) ((rgb & 0xFF00) >> 8)) / 255.f;
    CGFloat blue = ((float) (rgb & 0xFF)) / 255.f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
