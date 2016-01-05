//
//  UIImageView+CTH.h
//

#import <UIKit/UIKit.h>

@interface UIImageView (CTHImageView)

- (void)cth_tintImage;
- (void)cth_tintImageWithTintColor:(UIColor *)tintColor;
- (void)cth_circleView:(BOOL)activate;

@end
