//
//  UIViewController+CTH.h
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CTHAnimation) {
    CTHAnimationNone,
    CTHAnimationLeft,
    CTHAnimationRight,
    CTHAnimationTop,
    CTHAnimationBottom,
    CTHAnimationFadeIn,
    CTHAnimationFadeOut,
};

@interface UIViewController (CTHViewController)

@property (nonatomic) CTHAnimation openAnimation;
@property (nonatomic) CTHAnimation closeAnimation;
@property (nonatomic, copy, nullable)  void (^closeCompletion)(void);
@property (nonatomic, weak, nullable) IBOutlet  UIScrollView *cthScrollView;

+ (nullable UIViewController *)cth_viewControllerInitialStoryboard:(nonnull NSString *)name bundle:(nullable NSBundle *)storyboardBundleOrNil;
+ (nonnull UIViewController *)cth_viewControllerWithIdentifier:(nonnull NSString *)identifier storyboard:(nonnull NSString *)name bundle:(nullable NSBundle *)storyboardBundleOrNil;

- (void)cth_openViewController:(nonnull UIViewController *)viewControllerToOpen animation:(CTHAnimation)animation;
- (void)cth_openViewController:(nonnull UIViewController *)viewControllerToOpen animation:(CTHAnimation)animation completion:(nullable void (^)(void))completion;
- (void)cth_openViewController:(nonnull UIViewController *)viewControllerToOpen animation:(CTHAnimation)animation modal:(BOOL)modal completion:(nullable void (^)(void))completion;

- (void)cth_closeViewController;
- (void)cth_closeViewControllerAnimation:(CTHAnimation)animation;
- (void)cth_closeViewControllerCompletion:(nullable void (^)(void))completion;
- (void)cth_closeViewControllerAnimation:(CTHAnimation)animation completion:(nullable void (^)(void))completion;

- (void)cth_setBackBarButtonItemTitle:(nullable NSString *)title style:(UIBarButtonItemStyle)style;

- (BOOL)cth_shouldPopViewController;

@end
