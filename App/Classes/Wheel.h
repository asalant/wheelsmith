#import <Foundation/Foundation.h>
#import "Hub.h"
#import "Rim.h"

@interface Wheel : DomainObject {
    NSNumber *pk;
    NSNumber *spokePattern;
    Hub *hub;
    Rim *rim;
}

@property(nonatomic, retain) NSNumber *pk;
@property(nonatomic, retain) NSNumber *spokePattern;
@property(nonatomic, retain) Hub *hub;
@property(nonatomic, retain) Rim *rim;
@property(readonly) NSString *spokePatternDescription;

- (NSNumber *) spokeLengthWithFlangeDiameter:(NSNumber *)diameter flangeWidth:(NSNumber *)width;
- (NSNumber *) leftSpokeLength;
- (NSNumber *) rightSpokeLength;

@end
