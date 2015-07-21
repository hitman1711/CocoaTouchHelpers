//
//  UIDevice+CTH.m
//

#import "UIDevice+CTH.h"

@implementation UIDevice (CTHDevice)

- (void)forceOrientationWithSupportedOrientations:(NSUInteger)mask
{
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    NSNumber *orientation = nil;
    
    // all
    if (mask & UIInterfaceOrientationMaskAll
        ) {
        // do nothing
        
    // all but upside down
    } else if (mask & UIInterfaceOrientationMaskAllButUpsideDown) {
        if (currentOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        }
        
    // all but portrait
    } else if (mask & (UIInterfaceOrientationMaskLandscape |
                       UIInterfaceOrientationMaskPortraitUpsideDown)) {
        if (currentOrientation == UIInterfaceOrientationPortrait) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationPortraitUpsideDown];
        }
    
    // all but landscape right
    } else if (mask & (UIInterfaceOrientationMaskPortrait |
                       UIInterfaceOrientationMaskPortraitUpsideDown |
                       UIInterfaceOrientationMaskLandscapeLeft)) {
        if (currentOrientation == UIInterfaceOrientationLandscapeRight) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        }
    
    // all but landscape left
    } else if (mask & (UIInterfaceOrientationMaskPortrait |
                       UIInterfaceOrientationMaskPortraitUpsideDown |
                       UIInterfaceOrientationMaskLandscapeRight)) {
        if (currentOrientation == UIInterfaceOrientationLandscapeLeft) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        }
    
    // portrait and landscape left
    } else if (mask & (UIInterfaceOrientationMaskPortrait |
                       UIInterfaceOrientationMaskLandscapeLeft)) {
        if (currentOrientation != UIInterfaceOrientationPortrait &&
            currentOrientation != UIInterfaceOrientationLandscapeLeft) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        }
        
    // portrait and landscape right
    } else if (mask & (UIInterfaceOrientationMaskPortrait |
                       UIInterfaceOrientationMaskLandscapeRight)) {
        if (currentOrientation != UIInterfaceOrientationPortrait &&
            currentOrientation != UIInterfaceOrientationLandscapeRight) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        }
        
    // portrait and upside down
    } else if (mask & (UIInterfaceOrientationMaskPortrait |
                       UIInterfaceOrientationMaskPortraitUpsideDown)) {
        if (currentOrientation != UIInterfaceOrientationPortrait &&
            currentOrientation != UIInterfaceOrientationPortraitUpsideDown) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        }
        
    // upside and landscape left
    } else if (mask & (UIInterfaceOrientationMaskPortraitUpsideDown |
                       UIInterfaceOrientationMaskLandscapeLeft)) {
        if (currentOrientation != UIInterfaceOrientationPortraitUpsideDown &&
            currentOrientation != UIInterfaceOrientationLandscapeLeft) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationPortraitUpsideDown];
        }
        
    // upside and landscape right
    } else if (mask & (UIInterfaceOrientationMaskPortraitUpsideDown |
                       UIInterfaceOrientationMaskLandscapeRight)) {
        if (currentOrientation != UIInterfaceOrientationPortraitUpsideDown &&
            currentOrientation != UIInterfaceOrientationLandscapeRight) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationPortraitUpsideDown];
        }
        
    // landscape left and landscape right
    } else if (mask & (UIInterfaceOrientationMaskLandscapeLeft |
                       UIInterfaceOrientationMaskLandscapeRight)) {
        if (currentOrientation != UIInterfaceOrientationLandscapeLeft &&
            currentOrientation != UIInterfaceOrientationLandscapeRight) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        }
        
    // portrait
    } else if (mask & UIInterfaceOrientationMaskPortrait) {
        if (currentOrientation != UIInterfaceOrientationPortrait) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        }
        
    // upside down
    } else if (mask & UIInterfaceOrientationMaskPortraitUpsideDown) {
        if (currentOrientation != UIInterfaceOrientationPortraitUpsideDown) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationPortraitUpsideDown];
        }
        
    // landscape left
    } else if (mask & UIInterfaceOrientationMaskLandscapeLeft) {
        if (currentOrientation != UIInterfaceOrientationLandscapeLeft) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        }
    
    // landscape right
    } else if (mask & UIInterfaceOrientationMaskLandscapeRight) {
        if (currentOrientation != UIInterfaceOrientationLandscapeRight) {
            orientation = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        }
    }

    if (orientation != nil) {
        [[UIDevice currentDevice] setValue:orientation forKey:@"orientation"];
    }
}

@end
