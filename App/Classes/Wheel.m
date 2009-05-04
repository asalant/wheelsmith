#import "Wheel.h"
#import <math.h>
#import "Hub.h"
#import "Rim.h"

@implementation Wheel

@synthesize pk, spokePattern, hub, rim;

- (NSString *) spokePatternDescription {
    if ([spokePattern intValue] == 0)
        return @"Radial";
    else
        return [NSString stringWithFormat:@"%@ across", spokePattern];
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

+ (NSString *)defaultOrderBy {
    return @"created_at";
}

+ (NSString *)selectStatement {
    return @"select id, hub_id, rim_id, spoke_pattern, created_at from wheels";
}

+ (id) readFromRow:(DatabaseResultSet *)result {
    Wheel *wheel = [[[Wheel alloc] init] autorelease];
    wheel.pk = [result integerAt:0];
    wheel.hub = [Hub findFirstByCriteria:[NSString stringWithFormat:@"id = %@", [result integerAt:1]] orderBy:@"id"];
    wheel.rim = [Rim findFirstByCriteria:[NSString stringWithFormat:@"id = %@", [result integerAt:2]] orderBy:@"id"];
    wheel.spokePattern = [result integerAt:3];
    return wheel;
}

- (void) dealloc {
    [spokePattern release];
    [hub release];
    [rim release];
    [super dealloc];
}

@end
