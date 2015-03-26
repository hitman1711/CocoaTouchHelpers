//
//  NSString+CTH.m
//

#import "NSString+CTH.h"

@implementation NSString (CTHString)

- (NSString *)stringTrimmed
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

NSString *const emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";

- (BOOL)isEmail
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex] evaluateWithObject:self];
}

@end
