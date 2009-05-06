#import "Hub.h"
#import "Rim.h"

@protocol EditWheelDelegate
-(void)setHub:(Hub *)hub;
-(void)setRim:(Rim *)rim;
-(void)setSpokePattern:(NSNumber *)across;
@end