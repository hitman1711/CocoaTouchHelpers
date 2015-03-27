//
//  CTHView.m
//

#import "CTHView.h"

@implementation CTHView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.cornerRadius != 0.0f) {
        self.layer.cornerRadius = self.cornerRadius;
        self.clipsToBounds = YES;
    }
}

@end
