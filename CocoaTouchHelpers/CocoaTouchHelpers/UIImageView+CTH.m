//
//  UIImageView+CTH.m
//

#import "UIImageView+CTH.h"

#import <objc/runtime.h>

@implementation UIImageView (CTHImageView)

+ (void)load
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        NSArray *methodsToSwizzle = @[
                                      @[@"willMoveToSuperview:", @"cth_willMoveToSuperview:"],
                                      @[@"setImage:", @"cth_setImage:"],
                                      ];
        
        for (NSArray *method in methodsToSwizzle) {
            SEL originalSelector = NSSelectorFromString(method[0]);
            SEL swizzledSelector = NSSelectorFromString(method[1]);
            
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            
            if (didAddMethod) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    });
}

- (void)cth_tintImageWithColor:(UIColor *)tintColor
{
    self.tintColor = tintColor;
    self.cth_tintImage = YES;
}

- (void)cth_configureTintImage:(BOOL)activated
{
    self.image = [self.image imageWithRenderingMode:activated ? UIImageRenderingModeAlwaysTemplate : UIImageRenderingModeAlwaysOriginal];
}

#pragma mark - Swizzling

- (void)cth_willMoveToSuperview:(UIView *)newSuperview
{
    [self cth_willMoveToSuperview:newSuperview];
    [self cth_configureTintImage:self.cth_tintImage];
}

- (void)cth_setImage:(UIImage *)image
{
    [self cth_setImage:[image imageWithRenderingMode:self.cth_tintImage ? UIImageRenderingModeAlwaysTemplate : UIImageRenderingModeAlwaysOriginal]];
}

#pragma mark - Getters and Setters

- (BOOL)cth_tintImage
{
    return [objc_getAssociatedObject(self, @selector(cth_tintImage)) boolValue];
}

- (void)setCth_tintImage:(BOOL)cth_tintImage
{
    objc_setAssociatedObject(self, @selector(cth_tintImage), [NSNumber numberWithBool:cth_tintImage], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self cth_configureTintImage:cth_tintImage];
}

@end
