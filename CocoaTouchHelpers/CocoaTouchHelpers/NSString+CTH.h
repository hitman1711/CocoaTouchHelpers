//
//  NSString+CTH.h
//

#import <Foundation/Foundation.h>

@interface NSString (CTHString)

- (NSString *)stringTrimmed;
- (BOOL)isEmail;
- (NSString *)md5;
- (NSString *)sha256;
- (NSString *)sanitizeAsFilename;

@end
