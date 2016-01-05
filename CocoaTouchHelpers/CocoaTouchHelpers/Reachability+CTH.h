//
//  Reachability+CTH.h
//

#import "Reachability.h"

@interface Reachability (CTHReachability)

+ (void)cth_startSimpleNotifier;
+ (void)cth_stopSimpleNotifier;
+ (BOOL)cth_isConnected;

@end
