//
//  UIImageView+CTH.m
//

#import "UIImageView+CTH.h"

@implementation UIImageView (CTHImageView)

- (void)tintImage
{
    self.image = [self imageTinted];
}

- (void)tintImageWithTintColor:(UIColor *)tintColor
{
    self.tintColor = tintColor;
    
    [self tintImage];
}

- (UIImage *)imageTinted
{
    return [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)circleView:(BOOL)activate
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
