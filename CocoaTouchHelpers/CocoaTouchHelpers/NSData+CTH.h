//
//  NSData+CTH.h
//

#import <Foundation/Foundation.h>

@interface NSData (CTHData)

- (NSString *)cth_md5;
- (NSString *)cth_sha256;
- (NSString *)cth_hexadecimalString;

@end
