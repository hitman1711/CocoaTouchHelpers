//
//  UIImageView+CTH.h
//

#import <UIKit/UIKit.h>

@interface UIImageView (CTHImageView)

@property (nonatomic) IBInspectable BOOL cth_tintImage;

- (void)cth_tintImageWithTintColor:(UIColor *)tintColor;

@end
