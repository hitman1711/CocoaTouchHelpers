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
@property (nonatomic, copy) void (^closeCompletion)(void);
@property (nonatomic, weak) IBOutlet UIScrollView *cthScrollView;

+ (id)cth_viewControllerInitialStoryboard:(NSString *)name bundle:(NSBundle *)storyboardBundleOrNil;
+ (id)cth_viewControllerWithIdentifier:(NSString *)identifier storyboard:(NSString *)name bundle:(NSBundle *)storyboardBundleOrNil;

- (void)cth_openViewController:(UIViewController *)viewControllerToOpen animation:(CTHAnimation)animation modal:(BOOL)modal completion:(void (^)(void))completion;
- (void)cth_closeViewController;
- (void)cth_closeViewControllerAnimation:(CTHAnimation)animation;
- (void)cth_closeViewControllerCompletion:(void (^)(void))completion;
- (void)cth_closeViewControllerAnimation:(CTHAnimation)animation completion:(void (^)(void))completion;

- (void)cth_setBackBarButtonItemTitle:(NSString *)title style:(UIBarButtonItemStyle)style;

- (BOOL)cth_shouldPopViewController;

@end
