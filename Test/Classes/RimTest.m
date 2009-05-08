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
        assertThat([exception name], equalTo(@"PersistenceException"));
    }
}

- (void) testFindsAllRims {
    NSArray *rims = [Rim findAllOrderBy:@"description"];
    assertThat([NSNumber numberWithInt:[rims count]], equalTo([NSNumber numberWithInt:2]));
}

- (void) testHydratesRim {
    Rim *rim = [[Rim findAllOrderBy:@"brand"] objectAtIndex:0];
    assertThat(rim.brand, equalTo(@"Mavic"));
    assertThat(rim.erd, equalTo([NSNumber numberWithDouble:602]));
    
}

- (void) testSelectsBrandNames {
    NSArray *companies = [Rim selectBrandNames];
    assertThat([NSNumber numberWithInt:[companies count]], equalTo([NSNumber numberWithInt:2]));
}

@end