//
//  NSString+CTH.h
//

#import <Foundation/Foundation.h>

@interface NSString (CTHString)

- (NSString *)cth_stringTrimmed;
- (BOOL)cth_isEmail;
- (NSString *)cth_md5;
- (NSString *)cth_sha256;
- (NSString *)cth_sanitizeAsFilename;

@end
