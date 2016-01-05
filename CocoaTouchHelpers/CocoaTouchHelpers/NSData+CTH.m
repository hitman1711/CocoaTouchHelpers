//
//  NSData+CTH.m
//

#import "NSData+CTH.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSData (CTHData)

- (NSString *)cth_md5
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG) self.length, result);
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

- (NSString *)cth_sha256
{
    unsigned char hash[CC_SHA256_DIGEST_LENGTH];
    
    if (CC_SHA256(self.bytes, (CC_LONG) self.length, hash)) {
        NSData *sha2 = [NSData dataWithBytes:hash length:CC_SHA256_DIGEST_LENGTH];
        
        NSString *hash = [sha2 description];
        hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
        hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
        hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
        
        NSUInteger keyLength = [hash length];
        NSString *formattedKey = @"";
        
        for (int i = 0; i < keyLength; i += 2) {
            NSString *substr = [hash substringWithRange:NSMakeRange(i, 2)];
            
            if (i != keyLength-2) {
                substr = [substr stringByAppendingString:@":"];
            }
            
            formattedKey = [formattedKey stringByAppendingString:substr];
        }
        
        return formattedKey;
    }
    
    return nil;
}

- (NSString *)cth_hexadecimalString
{
    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];
    
    if (!dataBuffer) {
        return [NSString string];
    }
    
    NSUInteger dataLength = [self length];
    NSMutableString *hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i) {
        [hexString appendFormat:@"%02lx", (unsigned long)dataBuffer[i]];
    }
    
    return hexString;
}

@end
