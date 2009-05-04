#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>

#import "Rim.h"


@interface RimTest : SenTestCase {}

@end

@implementation RimTest

- (void) setUp {
    [DomainObject setDbName:@"test"];
}

- (void) testFailsIfDatabaseNotFound {
    @try {
        [Rim setDbName:@"foo"];
    }
    @catch (NSException *exception) {
        assertThat([exception name], equalTo(@"PersistenceException"));
    }
}

- (void) testFindsAllRims {
    NSArray *rims = [Rim findAll];
    assertThat([NSNumber numberWithInt:[rims count]], equalTo([NSNumber numberWithInt:2]));
}

- (void) testHydratesRim {
    Rim *rim = [[Rim findAll] objectAtIndex:0];
    assertThat(rim.brand, equalTo(@"Mavic"));
    assertThat(rim.erd, equalTo([NSNumber numberWithDouble:602]));
    
}

- (void) testSelectsBrandNames {
    NSArray *companies = [Rim selectBrandNames];
    assertThat([NSNumber numberWithInt:[companies count]], equalTo([NSNumber numberWithInt:2]));
}

- (void) tearDown {
    
}

@end