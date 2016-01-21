//
//  CTHFunctions.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern BOOL const CTHObjectIsNull(id x);

extern BOOL const CTHObjectIsEmpty(id x);

extern id const CTHObject(id object);

extern UIAlertController *const CTHAlertOK(NSString *title, NSString *message, void(^actionBlock)(UIAlertAction *action));

extern UIAlertController *const CTHAlertYesNo(NSString *title, NSString *message, void(^yesBlock)(UIAlertAction *action), void(^noBlock)(UIAlertAction *action));
