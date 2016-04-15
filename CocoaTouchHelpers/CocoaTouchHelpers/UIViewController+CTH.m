//
//  UIViewController+CTH.m
//

#import "UIViewController+CTH.h"

#import <objc/runtime.h>

#import "CTHTransition.h"
#import "UIResponder+CTH.h"

@implementation UIViewController (CTHViewController)

+ (void)load
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        NSArray *methodsToSwizzle = @[
                                      @[@"viewWillAppear:", @"cth_viewWillAppear:"],
                                      @[@"viewWillDisappear:", @"cth_viewWillDisappear:"],
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

- (void)cth_viewWillAppear:(BOOL)animated
{
    [self cth_viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
}

- (void)cth_viewWillDisappear:(BOOL)animated
{
    [self cth_viewWillDisappear:animated];
    
    [self deregisterForKeyboardNotifications];
}

- (void)registerForKeyboardNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(cth_keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(cth_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)deregisterForKeyboardNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [notificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)cth_keyboardDidShow:(NSNotification*)notification
{
    if (self.cthScrollView == nil) {
        return;
    }
    
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIScrollView *scrollView = self.cthScrollView;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    id currentResponder = [UIResponder cth_currentFirstResponder];
    
    if (currentResponder != nil && [currentResponder isKindOfClass:[UIView class]]) {
        UIView *viewResponder = (UIView *) currentResponder;
        
        // if active responder is hidden by keyboard, it will scroll
        CGRect aRect = self.view.frame;
        aRect.size.height -= kbSize.height;
        
        if (!CGRectContainsPoint(aRect, viewResponder.frame.origin) ) {
            [scrollView scrollRectToVisible:viewResponder.frame animated:YES];
        }
    }
}

- (void)cth_keyboardWillHide:(NSNotification*)notification
{
    if (self.cthScrollView == nil) {
        return;
    }
    
    UIScrollView *scrollView = self.cthScrollView;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

+ (UIViewController *)cth_viewControllerInitialStoryboard:(NSString *)name bundle:(NSBundle *)storyboardBundleOrNil
{
    return [[UIStoryboard storyboardWithName:name bundle:storyboardBundleOrNil] instantiateInitialViewController];
}

+ (UIViewController *)cth_viewControllerWithIdentifier:(NSString *)identifier storyboard:(NSString *)name bundle:(NSBundle *)storyboardBundleOrNil
{
    return [[UIStoryboard storyboardWithName:name bundle:storyboardBundleOrNil] instantiateViewControllerWithIdentifier:identifier];
}

- (void)cth_openViewController:(nonnull UIViewController *)viewControllerToOpen animation:(CTHAnimation)animation
{
    [self cth_openViewController:viewControllerToOpen animation:animation modal:NO completion:nil];
}

- (void)cth_openViewController:(nonnull UIViewController *)viewControllerToOpen animation:(CTHAnimation)animation completion:(nullable void (^)(void))completion
{
    [self cth_openViewController:viewControllerToOpen animation:animation modal:NO completion:completion];
}

- (void)cth_openViewController:(UIViewController *)viewControllerToOpen animation:(CTHAnimation)animation modal:(BOOL)modal completion:(void (^)(void))completion
{
    BOOL present = modal || self.navigationController == nil;
    
    viewControllerToOpen.openAnimation = animation;
    
    if (viewControllerToOpen.closeAnimation == CTHAnimationNone) {
        switch (animation) {
            case CTHAnimationNone: {
                viewControllerToOpen.closeAnimation = CTHAnimationNone;
            }
                break;
            case CTHAnimationBottom: {
                viewControllerToOpen.closeAnimation = CTHAnimationTop;
            }
                break;
            case CTHAnimationTop: {
                viewControllerToOpen.closeAnimation = CTHAnimationBottom;
            }
                break;
            case CTHAnimationLeft: {
                viewControllerToOpen.closeAnimation = CTHAnimationRight;
            }
                break;
            case CTHAnimationRight: {
                viewControllerToOpen.closeAnimation = CTHAnimationLeft;
            }
                break;
            case CTHAnimationFadeIn: {
                viewControllerToOpen.closeAnimation = CTHAnimationFadeOut;
            }
                break;
            case CTHAnimationFadeOut: {
                viewControllerToOpen.closeAnimation = CTHAnimationFadeIn;
            }
                break;
        }
    }
    
    viewControllerToOpen.transitioningDelegate = [CTHTransition shared];
    
    if (present) {
        viewControllerToOpen.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:viewControllerToOpen animated:YES completion:completion];
    
    } else {
        self.navigationController.delegate = [CTHTransition shared];
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:completion];
        [self.navigationController pushViewController:viewControllerToOpen animated:YES];
        [CATransaction commit];
    }
}

- (void)cth_closeViewController
{
    [self cth_closeViewControllerAnimation:self.closeAnimation completion:self.closeCompletion];
}

- (void)cth_closeViewControllerAnimation:(CTHAnimation)animation
{
    [self cth_closeViewControllerAnimation:animation completion:self.closeCompletion];
}

- (void)cth_closeViewControllerCompletion:(void (^)(void))completion
{
    [self cth_closeViewControllerAnimation:self.closeAnimation completion:completion];
}

- (void)cth_closeViewControllerAnimation:(CTHAnimation)animation completion:(void (^)(void))completion
{
    self.closeAnimation = animation;
    self.closeCompletion = completion;
    
    UINavigationController *navigationController = self.navigationController;
    
    BOOL pop = navigationController != nil && navigationController.viewControllers.count > 1;
    
    if (pop) {
        void(^closeBlock)() = ^{
            [CATransaction begin];
            [CATransaction setCompletionBlock:completion];
            [navigationController popViewControllerAnimated:YES];
            [CATransaction commit];
        };
        
        if (navigationController.viewControllers.lastObject == self) {
            closeBlock();
        
        } else if ([navigationController.viewControllers containsObject:self]) {
            NSUInteger index = [navigationController.viewControllers indexOfObject:self];
            
            if (index == 0) {
                [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:completion];
            } else {
                UIViewController *viewController = navigationController.viewControllers[index-1];
                [CATransaction begin];
                [CATransaction setCompletionBlock:closeBlock];
                [navigationController popToViewController:viewController animated:YES];
                [CATransaction commit];
            }
        }
    
    } else {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:completion];
    }
}

- (void)cth_setBackBarButtonItemTitle:(NSString *)title style:(UIBarButtonItemStyle)style
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:style target:nil action:nil];
}

- (BOOL)cth_shouldPopViewController
{
    return YES;
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

- (void (^)(void))closeCompletion
{
    return objc_getAssociatedObject(self, @selector(closeCompletion));
}

- (void)setCloseCompletion:(void (^)(void))closeCompletion
{
    objc_setAssociatedObject(self, @selector(closeCompletion), closeCompletion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIScrollView *)cthScrollView
{
    return objc_getAssociatedObject(self, @selector(cthScrollView));
}

- (void)setCthScrollView:(UIScrollView *)cthScrollView
{
    objc_setAssociatedObject(self, @selector(cthScrollView), cthScrollView, OBJC_ASSOCIATION_ASSIGN);
}

@end
