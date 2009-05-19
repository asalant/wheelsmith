#import "Hub.h"
#import "Rim.h"
#import "Wheel.h"

@protocol EditWheelDelegate
-(void)setHub:(Hub *)hub;
-(void)setRim:(Rim *)rim;
-(void)setSpokePattern:(NSNumber *)across;
@end