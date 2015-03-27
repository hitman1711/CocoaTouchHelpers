//
//  CTHDismissAnimation.m
//

#import "CTHDismissAnimation.h"

@interface CTHDismissAnimation ()

@property (nonatomic) CTHAnimation animation;
@property (nonatomic, copy) void (^completion)(void);

@end

@implementation CTHDismissAnimation

- (id)init
{
    self = [super init];
    
    if (self) {
        self.animation = CTHAnimationNone;
        self.completion = nil;
    }
    
    return self;
}

- (id)initWithAnimation:(CTHAnimation)animation completion:(void (^)(void))completion
{
    self = [super init];
    
    if (self) {
        self.animation = animation;
        self.completion = completion;
    }
    
    return self;
}

#pragma mark UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSTimeInterval duration = 0.0;
    
    switch (self.animation) {
        case CTHAnimationNone: {
            duration = 0.0;
        }
            break;
            
        default: {
            duration = 0.25;
        }
            break;
    }
    
    return duration;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGRect initialFrame = fromViewController.view.frame;
    CGRect finalFrame = fromViewController.view.frame;
    
    switch (self.animation) {
        case CTHAnimationNone: {
        }
            break;
        case CTHAnimationBottom: {
            finalFrame.origin = CGPointMake(0.0f, initialFrame.size.height);
        }
            break;
        case CTHAnimationTop: {
            finalFrame.origin = CGPointMake(0.0f, -initialFrame.size.height);
        }
            break;
        case CTHAnimationLeft: {
            finalFrame.origin = CGPointMake(-initialFrame.size.width, 0.0f);
        }
            break;
        case CTHAnimationRight: {
            finalFrame.origin = CGPointMake(initialFrame.size.width, 0.0f);
        }
            break;
    }
    
    [UIView animateWithDuration:duration animations:^{
        
        switch (self.animation) {
            case CTHAnimationNone: {
            }
                break;
            case CTHAnimationBottom: {
            }
                break;
            case CTHAnimationTop: {
            }
                break;
            case CTHAnimationLeft: {
            }
                break;
            case CTHAnimationRight: {
            }
                break;
        }
        
        fromViewController.view.frame = finalFrame;
        
    } completion:^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [transitionContext completeTransition:YES];
        
        if (self.completion) {
            self.completion();
        }
    }];
}

@end
