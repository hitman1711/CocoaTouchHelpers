//
//  UIImageView+CTH.h
//

#import <UIKit/UIKit.h>

@interface UIImageView (CTHImageView)

@property (nonatomic) IBInspectable BOOL cth_tintImage;

- (void)cth_tintImageWithColor:(UIColor *)tintColor;

@end
