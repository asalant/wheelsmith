#import <Foundation/Foundation.h>
#import "Hub.h"
#import "Rim.h"
#import "DomainObject.h"

@interface Wheel : DomainObject {
    NSNumber *spokePattern;
    NSNumber *hubId;
    NSNumber *rimId;
    Hub *hub;
    Rim *rim;
}

@property(nonatomic, retain) NSNumber *spokePattern;
@property(nonatomic, retain) NSNumber *hubId;
@property(nonatomic, retain) NSNumber *rimId;
@property(nonatomic, retain) Hub *hub;
@property(nonatomic, retain) Rim *rim;
@property(readonly) NSString *spokePatternDescription;
@property(readonly) BOOL isValid;

- (NSNumber *) spokeLengthWithFlangeDiameter:(NSNumber *)diameter flangeWidth:(NSNumber *)width;
- (NSNumber *) leftSpokeLength;
- (NSNumber *) rightSpokeLength;

@end