//
//  UIColor+CTH.h
//

#import <UIKit/UIKit.h>

@interface UIColor (CTHColor)

+ (instancetype)cth_colorWithHex:(NSInteger)rgb;
+ (instancetype)cth_colorWithHex:(NSInteger)rgb alpha:(CGFloat)alpha;

@end
