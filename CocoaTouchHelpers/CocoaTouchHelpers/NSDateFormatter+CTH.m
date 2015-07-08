//
//  NSDateFormatter+CTH.m
//

#import "NSDateFormatter+CTH.h"

@implementation NSDateFormatter (CTHDateFormatter)

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format
{
    if (date == nil) {
        return @"";
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    
    return [formatter stringFromDate:date];
}

@end
