//
//  UIViewController+CTH.h
//

#import <UIKit/UIKit.h>

typedef enum {
    CTHAnimationNone,
    CTHAnimationLeft,
    CTHAnimationRight,
    CTHAnimationTop,
    CTHAnimationBottom,
} CTHAnimation;

@interface UIViewController (CTHViewController) <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (nonatomic) CTHAnimation closeAnimation;
@property (nonatomic, copy) void (^closeCompletion)(void);

+ (id)viewControllerInitialStoryboard:(NSString *)name bundle:(NSBundle *)storyboardBundleOrNil;
+ (id)viewControllerWithIdentifier:(NSString *)identifier storyboard:(NSString *)name bundle:(NSBundle *)storyboardBundleOrNil;

- (void)openViewController:(UIViewController *)viewControllerToOpen animation:(CTHAnimation)animation modal:(BOOL)modal completion:(void (^)(void))completion;

@end
