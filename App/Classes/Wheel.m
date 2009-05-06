#import "Wheel.h"
#import <math.h>
#import "Hub.h"
#import "Rim.h"

@implementation Wheel

@synthesize spokePattern, hubId, rimId, hub, rim;

+ (NSDictionary *) dataMap {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"pk", @"id",
            @"createdAt", @"created_at",
            @"updatedAt", @"updated_at",
            @"spokePattern", @"spoke_pattern",
            @"hubId", @"hub_id",
            @"rimId", @"rim_id", 
            nil];
}

+ (id) readFromRow:(DatabaseResultSet *)result {
    Wheel *wheel = (Wheel *) [super readFromRow:result];
    wheel.hub = [Hub find:wheel.hubId];
    wheel.rim = [Rim find:wheel.rimId];
    return wheel;
}

- (NSString *) spokePatternDescription {
    if (!spokePattern)
        return nil;
    else if ([spokePattern intValue] == 0)
        return @"radial";
    else
        return [NSString stringWithFormat:@"%@ across", spokePattern];
}

- (BOOL) isValid {
    return self.hub && self.rim && self.spokePattern;
}

- (NSNumber *) leftSpokeLength {
    return [self spokeLengthWithFlangeDiameter:hub.leftFlangeDiameter flangeWidth:hub.leftFlangeToCenter];
}

- (NSNumber *) rightSpokeLength {
    return [self spokeLengthWithFlangeDiameter:hub.rightFlangeDiameter flangeWidth:hub.rightFlangeToCenter];
}

- (NSNumber *) spokeLengthWithFlangeDiameter:(NSNumber *)diameter flangeWidth:(NSNumber *)width {
    // =SQRT(
    //      (hub.leftFlangeDiameter/2*SIN(2*PI()*spokePattern/(spokeCount/2)))^2
    //      + (rim.erd/2-((hub.leftFlangeDiameter/2)*COS(2*PI()*spokePattern/(spokeCount/2))))^2
    //      + (hub.leftFlangeToCenter - rim.offset)^2
    // )
    // - hub.spokeHoleDiameter/2
    return [NSNumber numberWithDouble:
            ceil(sqrt(pow([diameter doubleValue]/2 * sin(2*M_PI*[spokePattern doubleValue]/([hub.holeCount doubleValue]/2)), 2) + 
                      pow([rim.erd doubleValue]/2 - (([diameter doubleValue]/2)*cos(2*M_PI*[spokePattern doubleValue]/([hub.holeCount doubleValue]/2))),2) + 
                      pow([width doubleValue] - [rim.offset doubleValue],2))
                 - 2.5/2)
            ]; 
}

- (void) dealloc {
    [spokePattern release];
    [hub release];
    [rim release];
    [super dealloc];
}

@end
