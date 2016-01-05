//
//  NSString+CTH.m
//

#import "NSString+CTH.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CTHString)

- (NSString *)cth_stringTrimmed
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

static NSString *const emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";

- (BOOL)cth_isEmail
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex] evaluateWithObject:self];
}

- (NSString *)cth_md5
{
    const char *cstr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, (CC_LONG) strlen(cstr), result);
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

- (NSString *)cth_sha256
{
    const char *cstr = [self UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(cstr, (CC_LONG) strlen(cstr), result);
    
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [string appendFormat:@"%02x",result[i]];
    }
    
    return string;
}

- (NSString *)cth_sanitizeAsFilename
{
    NSCharacterSet *illegalSet = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>"];
    return [[self componentsSeparatedByCharactersInSet:illegalSet] componentsJoinedByString:@""];
}

@end
