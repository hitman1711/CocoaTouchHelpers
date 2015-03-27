//
//  CTHImageView.h
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface CTHImageView : UIImageView

- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (instancetype)initWithImage:(UIImage *)image;
- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

@end
