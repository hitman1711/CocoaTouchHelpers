//
//  UIResponder+CTH.m
//
//

#import "UIResponder+CTH.h"

@implementation UIResponder (CTHResponder)

static __weak id currentFirstResponder = nil;

+ (id)cth_currentFirstResponder
{
    currentFirstResponder = nil;
    
    [[UIApplication sharedApplication] sendAction:@selector(cth_findFirstResponder:) to:nil from:nil forEvent:nil];
    
    return currentFirstResponder;
}

- (void)cth_findFirstResponder:(id)sender
{
    currentFirstResponder = self;
}

@end
