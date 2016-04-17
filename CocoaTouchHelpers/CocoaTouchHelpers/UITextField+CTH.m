//
//  UITextField+CTH.m
//

#import "UITextField+CTH.h"

#import <objc/runtime.h>

@implementation UITextField (CTHTextField)

+ (void)load
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        NSArray *methodsToSwizzle = @[
                                      @[@"setPlaceholder:", @"cth_setPlaceholder:"],
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

- (void)cth_configurePlaceholderColor:(UIColor *)color
{
    NSAttributedString *attributedPlaceholder = self.attributedPlaceholder;
    
    if (color != nil) {
        NSString *placeholder = self.placeholder != nil ? self.placeholder : @"";
        attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    self.attributedPlaceholder = attributedPlaceholder;
}

#pragma mark - Swizzling

- (void)cth_setPlaceholder:(NSString *)placeholder
{
    [self cth_setPlaceholder:placeholder];
    
    [self cth_configurePlaceholderColor:self.cth_placeholderColor];
}

#pragma mark - Getters and Setters

- (UIColor *)cth_placeholderColor
{
    return objc_getAssociatedObject(self, @selector(cth_placeholderColor));
}

- (void)setCth_placeholderColor:(UIColor *)cth_placeholderColor
{
    objc_setAssociatedObject(self, @selector(cth_placeholderColor), cth_placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self cth_configurePlaceholderColor:cth_placeholderColor];
}

@end
