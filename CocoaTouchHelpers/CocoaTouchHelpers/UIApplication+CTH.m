//
//  UIApplication+CTH.m
//

#import "UIApplication+CTH.h"

@implementation UIApplication (CTHApplication)

+ (void)cth_setStatusBarStyle:(UIStatusBarStyle)style animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:style animated:animated];
}

@end
