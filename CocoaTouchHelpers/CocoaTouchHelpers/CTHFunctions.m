//
//  CTHFunctions.m
//

#import "CTHFunctions.h"

BOOL const CTHObjectIsNull(id x) {
    return (x == nil) || (x == NULL) || ([[NSNull null] isEqual:x]);
}

BOOL const CTHObjectIsEmpty(id x) {
    
    BOOL empty = CTHObjectIsNull(x);
    
    if (!empty) {
        if ([x isKindOfClass:NSString.class]) {
            NSString *string = (NSString *) x;
            empty = [string isEqualToString:@""];
            
        } else if ([x isKindOfClass:NSArray.class]) {
            NSArray *array = (NSArray *) x;
            empty = array.count < 1;
            
        } else if ([x isKindOfClass:NSDictionary.class]) {
            NSDictionary *dictionary = (NSDictionary *) x;
            empty = dictionary.count < 1;
        }
    }
    
    return empty;
}

id const CTHObject(id object)
{
    if (object == nil || object == NULL) {
        return [NSNull null];
    }
    
    return object;
}

UIAlertController *const CTHAlertOK(NSString *title, NSString *message, void(^actionBlock)(UIAlertAction *action))
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertOKAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleCancel handler:actionBlock];
    
    [alertController addAction:alertOKAction];
    
    return alertController;
}

UIAlertController *const CTHAlertYesNo(NSString *title, NSString *message, void(^yesBlock)(UIAlertAction *action), void(^noBlock)(UIAlertAction *action))
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Sim", @"") style:UIAlertActionStyleDefault handler:yesBlock];
    [alertController addAction:yesAction];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Não", @"") style:UIAlertActionStyleCancel handler:noBlock];
    [alertController addAction:noAction];
    
    return alertController;
}
