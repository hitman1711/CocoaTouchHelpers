//
//  UIView+CTH.m
//

#import "UIView+CTH.h"

@implementation UIView (CTHView)

- (id)cth_firstResponder
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

@end
