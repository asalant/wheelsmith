#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>

#import "Rim.h"


@interface RimTest : SenTestCase {}

@end

@implementation RimTest

- (void) setUp {
	[DomainObject setDatabase:[Database create:@"test" overwrite:YES]];
}

- (void) testFailsIfDatabaseNotFound {
    @try {
        [DomainObject setDatabase:[Database create:@"foo" overwrite:YES]];
    }
    @catch (NSException *exception) {
        assertThat([exception name], is(@"PersistenceException"));
    }
}

- (void) testFindsAllRims {
    NSArray *rims = [Rim findAllOrderBy:@"description"];
    assertThat([NSNumber numberWithInt:[rims count]], is([NSNumber numberWithInt:2]));
}

-(void)testFindsByBrandAndHoleCount {
    assertThat([NSNumber numberWithInt:[Rim findByBrand:@"Mavic" andHoleCount:[NSNumber numberWithInt:32]].count], 
               is([NSNumber numberWithInt:1]));
    assertThat([NSNumber numberWithInt:[Rim findByBrand:@"Mavic" andHoleCount:[NSNumber numberWithInt:36]].count], 
               is([NSNumber numberWithInt:0]));
    
}

-(void)testFindsByBrandAndNilHoleCount {
    assertThat([NSNumber numberWithInt:[Rim findByBrand:@"Mavic" andHoleCount:nil].count], 
               is([NSNumber numberWithInt:1]));
    
}

- (void) testHydratesRim {
    Rim *rim = [[Rim findAllOrderBy:@"brand"] objectAtIndex:0];
    assertThat(rim.brand, is(@"Mavic"));
    assertThat(rim.verified, is([NSNumber numberWithBool:YES]));
    assertThat(rim.erd, is([NSNumber numberWithDouble:602]));
    
}

- (void) testSelectsBrandNames {
    NSArray *companies = [Rim selectBrandNames];
    assertThat([NSNumber numberWithInt:[companies count]], is([NSNumber numberWithInt:2]));
    assertThat([companies objectAtIndex:0], is(@"Mavic"));
    assertThat([companies objectAtIndex:1], is(@"Velocity")); 
}

-(void)testCreatesRim {
    Rim *rim = [[[Rim alloc] init] autorelease];
    rim.brand = @"Brand";
    [rim create];
    assertThat(rim.pk, notNilValue());
    assertThat(rim.verified, is([NSNumber numberWithBool:NO]));
}

@end