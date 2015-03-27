//
//  UIApplication+CTH.m
//  CocoaTouchHelpers
//
//  Created by felipowsky on 3/27/15.
//  Copyright (c) 2015 felipowsky. All rights reserved.
//

#import "UIApplication+CTH.h"

@implementation UIApplication (CTHApplication)

- (void)setStatusBarStyle:(UIStatusBarStyle)style animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:style animated:animated];
}

@end
