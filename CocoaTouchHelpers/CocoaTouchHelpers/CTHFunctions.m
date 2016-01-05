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
