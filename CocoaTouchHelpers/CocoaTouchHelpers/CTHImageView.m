//
//  CTHImageView.m
//

#import "CTHImageView.h"

@implementation CTHImageView

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setImage:self.image];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setImage:self.image];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setImage:self.image];
    }
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    
    if (self) {
        [self setImage:self.image];
    }
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    self = [super initWithImage:image highlightedImage:highlightedImage];
    
    if (self) {
        [self setImage:self.image];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    [super setImage:[self roundImage:image]];
}

- (UIImage *)roundImage:(UIImage *)image
{
    CGRect rect = self.bounds;
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    [path addClip];
    
    [image drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
