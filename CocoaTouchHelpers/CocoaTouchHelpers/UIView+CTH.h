//
//  UIView+CTH.h
//

#import <UIKit/UIKit.h>

@interface UIView (CTHView)

@property (nonatomic, strong, readonly) UIView *cth_firstResponder;
@property (nonatomic, assign) IBInspectable BOOL cth_circleView;
@property (nonatomic, assign) IBInspectable CGFloat cth_cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat cth_borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *cth_borderColor;

@end
