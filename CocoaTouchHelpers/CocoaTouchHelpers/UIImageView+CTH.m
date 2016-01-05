//
//  UIImageView+CTH.m
//

#import "UIImageView+CTH.h"

@implementation UIImageView (CTHImageView)

- (void)cth_tintImage
{
    self.image = [self cth_imageTinted];
}

- (void)cth_tintImageWithTintColor:(UIColor *)tintColor
{
    self.tintColor = tintColor;
    
    [self cth_tintImage];
}

- (UIImage *)cth_imageTinted
{
    return [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)cth_circleView:(BOOL)activate
{
    if (activate) {
        float size = MIN(self.frame.size.width, self.frame.size.height);
        
        self.layer.cornerRadius = size / 2;
        self.layer.masksToBounds = YES;
        
    } else {
        self.layer.cornerRadius = 0.f;
    }
}

@end
