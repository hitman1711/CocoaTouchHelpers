//
//  Reachability+CTH.h
//

@import Reachability;

@interface Reachability (CTHReachability)

+ (void)cth_startSimpleNotifier;
+ (void)cth_stopSimpleNotifier;
+ (BOOL)cth_isConnected;

@end
