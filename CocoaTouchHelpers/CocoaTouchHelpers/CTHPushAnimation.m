//
//  CTHPushAnimation.m
//

#import "CTHPushAnimation.h"

@interface CTHPushAnimation ()

@property (nonatomic) CTHAnimation animation;
@property (nonatomic, copy) void (^completion)(void);

@end

@implementation CTHPushAnimation

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
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    
    [toViewController.view layoutIfNeeded];
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGRect initialFrame = toViewController.view.frame;
    CGRect finalFrame = toViewController.view.frame;
    
    switch (self.animation) {
        case CTHAnimationNone: {
        }
            break;
        case CTHAnimationBottom: {
            initialFrame.origin = CGPointMake(0.0f, -initialFrame.size.height);
        }
            break;
        case CTHAnimationTop: {
            initialFrame.origin = CGPointMake(0.0f, initialFrame.size.height);
        }
            break;
        case CTHAnimationLeft: {
            initialFrame.origin = CGPointMake(initialFrame.size.width, 0.0f);
        }
            break;
        case CTHAnimationRight: {
            initialFrame.origin = CGPointMake(-initialFrame.size.width, 0.0f);
        }
            break;
    }
    
    toViewController.view.frame = initialFrame;
    
    [[transitionContext containerView] addSubview:toViewController.view];
    
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
        
        toViewController.view.frame = finalFrame;
        
    } completion:^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [transitionContext completeTransition:YES];
        
        if (self.completion) {
            self.completion();
        }
    }];
}

@end