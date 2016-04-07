//
//  CTHPushAnimation.h
//

#import <UIKit/UIKit.h>

#import "UIViewController+CTH.h"

@interface CTHPushAnimation : NSObject <UIViewControllerAnimatedTransitioning>

- (id)initWithAnimation:(CTHAnimation)animation;

@end
