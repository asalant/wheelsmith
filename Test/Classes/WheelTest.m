#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>

#import "Hub.h"
#import "Rim.h"
#import "Wheel.h"


@interface WheelTest : SenTestCase {}

@end

@implementation WheelTest


- (void) setUp {
    [DomainObject setDbName:@"test"];
}

- (void) testFindsAllWheels {
    NSArray *wheels = [Wheel findAll];
    assertThat([NSNumber numberWithInt:wheels.count], equalTo([NSNumber numberWithInt:2]));
}


- (void) testHydratesWheel {
    Wheel *wheel = [[Wheel findAll] objectAtIndex:0];
    assertThat(wheel.hub, notNilValue());
    assertThat(wheel.rim, notNilValue());
    assertThat(wheel.spokePattern, equalTo([NSNumber numberWithInt:3]));
}

- (void) testCalculatesSpokeLength {
 
    Wheel *wheel = [[Wheel alloc] init];
    wheel.spokePattern = [NSNumber numberWithInt:3];
    
    Rim *rim = [[[Rim alloc] init] autorelease];
    rim.brand = @"Mavic";
    rim.description = @"EX823";
    rim.erd = [NSNumber numberWithDouble:532.0];
    rim.offset = [NSNumber numberWithDouble:0.0];
    
    Hub *hub = [[[Hub alloc] init] autorelease];
    hub.brand = @"DT";
    hub.description = @"240 6 bolt rear";
    hub.holeCount = [NSNumber numberWithInt:32];
    hub.leftFlangeDiameter = [NSNumber numberWithDouble:57.0];
    hub.leftFlangeToCenter = [NSNumber numberWithDouble:33.3];
    hub.rightFlangeDiameter = [NSNumber numberWithDouble:47.5];
    hub.rightFlangeToCenter = [NSNumber numberWithDouble:19.3];
    
    wheel.rim = rim;
    wheel.hub = hub;
    
    assertThat([wheel leftSpokeLength], equalTo([NSNumber numberWithDouble:258.0]));
    assertThat([wheel rightSpokeLength], equalTo([NSNumber numberWithDouble:258.0]));
}

- (void) testPatternDescriptionIsRadial {
    Wheel *wheel = [[Wheel alloc] init];
    wheel.spokePattern = [NSNumber numberWithInt:0];
    
    assertThat(wheel.spokePatternDescription, equalTo(@"radial"));
    
}

- (void) testPatternDescriptionNAcross {
    Wheel *wheel = [[Wheel alloc] init];
    wheel.spokePattern = [NSNumber numberWithInt:3];
    
    assertThat(wheel.spokePatternDescription, equalTo(@"3 across"));
    
}


@end
