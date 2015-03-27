//
//  UIViewController+CTH.m
//

#import "UIViewController+CTH.h"

#import <objc/runtime.h>

#import "CTHPresentAnimation.h"
#import "CTHDismissAnimation.h"
#import "CTHPushAnimation.h"
#import "CTHPopAnimation.h"

@interface UIViewController ()

@property (nonatomic) CTHAnimation openAnimation;
@property (nonatomic, copy) void (^openCompletion)(void);

@end

@implementation UIViewController (CTHViewController)

+ (id)viewControllerInitialStoryboard:(NSString *)name bundle:(NSBundle *)storyboardBundleOrNil
{
    return [[UIStoryboard storyboardWithName:name bundle:storyboardBundleOrNil] instantiateInitialViewController];
}

+ (id)viewControllerWithIdentifier:(NSString *)identifier storyboard:(NSString *)name bundle:(NSBundle *)storyboardBundleOrNil
{
    return [[UIStoryboard storyboardWithName:name bundle:storyboardBundleOrNil] instantiateViewControllerWithIdentifier:identifier];
}

- (void)openViewController:(UIViewController *)viewControllerToOpen animation:(CTHAnimation)animation modal:(BOOL)modal completion:(void (^)(void))completion
{
    BOOL present = modal || self.navigationController == nil;
    
    self.openAnimation = animation;
    self.openCompletion = completion;
    
    switch (animation) {
        case CTHAnimationNone: {
            self.closeAnimation = CTHAnimationNone;
        }
            break;
        case CTHAnimationBottom: {
            self.closeAnimation = CTHAnimationTop;
        }
            break;
        case CTHAnimationTop: {
            self.closeAnimation = CTHAnimationBottom;
        }
            break;
        case CTHAnimationLeft: {
            self.closeAnimation = CTHAnimationRight;
        }
            break;
        case CTHAnimationRight: {
            self.closeAnimation = CTHAnimationLeft;
        }
            break;
    }
    
    viewControllerToOpen.transitioningDelegate = self;
    
    if (present) {
        viewControllerToOpen.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:viewControllerToOpen animated:YES completion:nil];
    
    } else {
        self.navigationController.delegate = self;
        [self.navigationController pushViewController:viewControllerToOpen animated:YES];
    }
}

#pragma mark UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[CTHPresentAnimation alloc] initWithAnimation:self.openAnimation completion:self.openCompletion];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[CTHDismissAnimation alloc] initWithAnimation:self.closeAnimation completion:dismissed.closeCompletion];
}

#pragma mark UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    id<UIViewControllerAnimatedTransitioning> animation = nil;
    
    if (operation == UINavigationControllerOperationPush) {
        animation = [[CTHPushAnimation alloc] initWithAnimation:self.openAnimation completion:self.openCompletion];
        
    } else if (operation == UINavigationControllerOperationPop) {
        animation = [[CTHPopAnimation alloc] initWithAnimation:self.closeAnimation completion:fromVC.closeCompletion];
    }
    
    return animation;
}

#pragma mark Getters and Setters

- (CTHAnimation)openAnimation
{
    return [objc_getAssociatedObject(self, @selector(openAnimation)) intValue];
}

- (void)setOpenAnimation:(CTHAnimation)openAnimation
{
    objc_setAssociatedObject(self, @selector(openAnimation), [NSNumber numberWithInt:openAnimation], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CTHAnimation)closeAnimation
{
    return [objc_getAssociatedObject(self, @selector(closeAnimation)) intValue];
}

- (void)setCloseAnimation:(CTHAnimation)closeAnimation
{
    objc_setAssociatedObject(self, @selector(closeAnimation), [NSNumber numberWithInt:closeAnimation], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))openCompletion
{
    return objc_getAssociatedObject(self, @selector(openCompletion));
}

- (void)setOpenCompletion:(void (^)(void))openCompletion
{
    objc_setAssociatedObject(self, @selector(openCompletion), openCompletion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))closeCompletion
{
    return objc_getAssociatedObject(self, @selector(closeCompletion));
}

- (void)setCloseCompletion:(void (^)(void))closeCompletion
{
    objc_setAssociatedObject(self, @selector(closeCompletion), closeCompletion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
