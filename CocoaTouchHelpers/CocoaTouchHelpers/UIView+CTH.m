//
//  UIView+CTH.m
//

#import "UIView+CTH.h"

#import <objc/runtime.h>

@implementation UIView (CTHView)

- (void)cth_configureCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
}

- (void)cth_configureBorderWidth:(CGFloat)width
{
    self.layer.borderWidth = width;
}

- (void)cth_configureBorderColor:(UIColor *)color
{
    self.layer.borderColor = color.CGColor;
}

- (void)cth_configureCircleView:(BOOL)activated
{
    if (activated) {
        float size = MIN(self.frame.size.width, self.frame.size.height);
        self.layer.cornerRadius = size / 2;
        self.layer.masksToBounds = YES;
        
    } else {
        self.layer.cornerRadius = 0.f;
    }
    
    [self cth_configureCornerRadius:self.layer.cornerRadius];
}

#pragma mark - Getters and Setters

- (UIView *)cth_firstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subview in self.subviews) {
        id responder = [subview cth_firstResponder];
        
        if (responder != nil) {
            return responder;
        }
    }
    
    return nil;
}

- (BOOL)cth_circleView
{
    return [objc_getAssociatedObject(self, @selector(cth_circleView)) boolValue];
}

- (void)setCth_circleView:(BOOL)cth_circleView
{
    objc_setAssociatedObject(self, @selector(cth_circleView), [NSNumber numberWithBool:cth_circleView], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self cth_configureCircleView:cth_circleView];
}

- (CGFloat)cth_cornerRadius
{
    return [objc_getAssociatedObject(self, @selector(cth_cornerRadius)) floatValue];
}

- (void)setCth_cornerRadius:(CGFloat)cth_cornerRadius
{
    objc_setAssociatedObject(self, @selector(cth_cornerRadius), [NSNumber numberWithFloat:cth_cornerRadius], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self cth_configureCornerRadius:cth_cornerRadius];
}

- (CGFloat)cth_borderWidth
{
    return [objc_getAssociatedObject(self, @selector(cth_borderWidth)) floatValue];
}

- (void)setCth_borderWidth:(CGFloat)cth_borderWidth
{
    objc_setAssociatedObject(self, @selector(cth_borderWidth), [NSNumber numberWithFloat:cth_borderWidth], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self cth_configureBorderWidth:cth_borderWidth];
}

- (UIColor *)cth_borderColor
{
    return objc_getAssociatedObject(self, @selector(cth_borderColor));
}

- (void)setCth_borderColor:(UIColor *)cth_borderColor
{
    objc_setAssociatedObject(self, @selector(cth_borderColor), cth_borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self cth_configureBorderColor:cth_borderColor];
}

@end
