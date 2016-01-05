//
//  NSDateFormatter+CTH.m
//

#import "NSDateFormatter+CTH.h"

@implementation NSDateFormatter (CTHDateFormatter)

+ (NSString *)cth_stringFromDate:(NSDate *)date format:(NSString *)format
{
    if (date == nil) {
        return @"";
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    
    return [formatter stringFromDate:date];
}

+ (NSDate *)cth_dateFromString:(NSString *)string format:(NSString *)format
{
    if (string == nil || string == NULL || [[NSNull null] isEqual:string]) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    
    return [formatter dateFromString:string];
}

@end
