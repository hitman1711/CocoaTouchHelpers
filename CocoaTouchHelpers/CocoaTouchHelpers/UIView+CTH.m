//
//  UIView+CTH.m
//

#import "UIView+CTH.h"

#import <objc/runtime.h>

@implementation UIView (CTHView)

- (void)cth_configureCircleView:(BOOL)activated
{
    if (activated) {
        float size = MIN(self.frame.size.width, self.frame.size.height);
        self.layer.cornerRadius = size / 2;
        self.layer.masksToBounds = YES;
        
    } else {
        self.layer.cornerRadius = 0.f;
    }
}

#pragma mark - Interface Builder

- (void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    
    [self cth_configureCircleView:self.cth_circleView];
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

@end
