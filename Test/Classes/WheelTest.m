#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>

#import "Hub.h"
#import "Rim.h"
#import "Wheel.h"
#import "DomainObject.h"
#import "Database.h"

@interface WheelTest : SenTestCase {}

@end

@implementation WheelTest


- (void) setUp {
	[DomainObject setDatabase:[Database create:@"test" overwrite:YES]];
}

- (void) testFindsAllWheels {
    NSArray *wheels = [Wheel findAllOrderBy:nil];
    assertThat([NSNumber numberWithInt:wheels.count], equalTo([NSNumber numberWithInt:2]));
}


- (void) testHydratesWheel {
    Wheel *wheel = [Wheel findFirstByCriteria:@"spoke_pattern = 0" orderBy:nil];
    assertThat(wheel.spokePattern, equalTo([NSNumber numberWithInt:0]));
    assertThat(wheel.hub, notNilValue());
    assertThat(wheel.hubId, is(wheel.hub.pk));
    assertThat(wheel.rim, notNilValue());
    assertThat(wheel.hubId, is(wheel.hub.pk));
}

- (void) testAddsEmptyWheel {
    Wheel *wheel = [[[Wheel alloc] init] autorelease];
    [wheel create];
    assertThat(wheel.pk, notNilValue());
    assertThat(wheel.updatedAt, notNilValue());
}

- (void) testAddsWheel {
    Wheel *wheel = [[[Wheel alloc] init] autorelease];
    wheel.rim = [[Rim findAllOrderBy:nil] objectAtIndex:0];
    wheel.hub = [[Hub findAllOrderBy:nil] objectAtIndex:0];
    wheel.spokePattern = [NSNumber numberWithInt:3];
    NSDate *before = [NSDate date];
    [wheel create];
    assertThat(wheel.pk, notNilValue());
    assertThat([NSNumber numberWithBool:[wheel.createdAt isGreaterThan:before]],
               is([NSNumber numberWithBool:YES]));
    
    Wheel *saved = [Wheel find:wheel.pk];
    assertThat(saved, notNilValue());
    assertThat(saved.spokePattern, is([NSNumber numberWithInt:3]));
    assertThat([saved.updatedAt description], is([wheel.updatedAt description]));
    assertThat([saved.createdAt description], is([wheel.createdAt description]));
    assertThat(saved.rim, notNilValue());
    assertThat(saved.hub, notNilValue());
}

-(void)testUpdatesWheel {
    Wheel *wheel = [Wheel findFirstByCriteria:@"spoke_pattern = 0" orderBy:nil];
    NSDate *lastCreatedAt = wheel.createdAt;
    NSDate *lastUpdatedAt = wheel.updatedAt;
    wheel.spokePattern = [NSNumber numberWithInt:3];
    [wheel update];
    assertThat(wheel.createdAt, is(lastCreatedAt));
    assertThat([NSNumber numberWithBool:[wheel.updatedAt isGreaterThan:lastUpdatedAt]], 
               is([NSNumber numberWithBool:YES]));
    
    Wheel *updated = [Wheel find:wheel.pk];
    assertThat([updated.updatedAt description], is([wheel.updatedAt description]));
    assertThat(updated.spokePattern, is(wheel.spokePattern));
}

-(void)testSavesExistingWheel {
    Wheel *wheel = [Wheel findFirstByCriteria:@"spoke_pattern = 0" orderBy:nil];
    wheel.spokePattern = [NSNumber numberWithInt:3];
    [wheel save];
    
    Wheel *updated = [Wheel find:wheel.pk];
    assertThat(updated.spokePattern, is(wheel.spokePattern));    
}

-(void)testSavesNewWheel {
    Wheel *wheel = [[[Wheel alloc] init] autorelease];
    [wheel save];
    
    assertThat(wheel.pk, notNilValue());    
}

-(void)testDeletesWheel {
    Wheel *wheel = [Wheel findFirstByCriteria:@"spoke_pattern = 0" orderBy:nil];
    [wheel delete];
    assertThat([Wheel find:wheel.pk], nilValue());
}

-(void)testRevertsWheel {
    Wheel *wheel = [Wheel findFirstByCriteria:@"spoke_pattern = 0" orderBy:nil];
    wheel.spokePattern = [NSNumber numberWithInt:3];
    wheel.hub = nil;
    wheel.rim = nil;
    
    [wheel revert];
    assertThat(wheel.spokePattern, is([NSNumber numberWithInt:0]));
    assertThat(wheel.hub, notNilValue());
    assertThat(wheel.rim, notNilValue());
    
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

-(void) testEmptyWheelIsInvalid {
    Wheel *wheel = [[[Wheel alloc] init] autorelease];
    assertThat([NSNumber numberWithBool:wheel.isValid], 
               is([NSNumber numberWithBool:NO]));
}

-(void) testCompleteWheelIsValid {
    Wheel *wheel = [[Wheel findAllOrderBy:nil] objectAtIndex:0];
    assertThat([NSNumber numberWithBool:wheel.isValid], 
               is([NSNumber numberWithBool:YES]));
}


@end
