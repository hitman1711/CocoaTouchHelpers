//
//  NSDateFormatter+CTH.h
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (CTHDateFormatter)

+ (NSString *)cth_stringFromDate:(NSDate *)date format:(NSString *)format;
+ (NSDate *)cth_dateFromString:(NSString *)string format:(NSString *)format;

@end
