//
//  UIView+CTH.h
//

#import <UIKit/UIKit.h>

@interface UIView (CTHView)

@property (nonatomic, strong, readonly) UIView *cth_firstResponder;
@property (nonatomic) IBInspectable BOOL cth_circleView;

@end
