#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>

#import "Hub.h"
#import "Rim.h"


@interface HubTest : SenTestCase {}

@end

@implementation HubTest

- (void) setUp {
    [DomainObject setDbName:@"test"];
}

- (void) testFindsAllHubs {
    NSArray *hubs = [Hub findAll];
    assertThat([NSNumber numberWithInt:hubs.count], equalTo([NSNumber numberWithInt:2]));
}

- (void) testHydratesHub {
    Hub *hub = [[Hub findAll] objectAtIndex:0];
    assertThat(hub.brand, equalTo(@"Campagnolo"));
}

- (void) testSelectsBrandNames {
    NSArray *companies = [Hub selectBrandNames];
    assertThat([NSNumber numberWithInt:[companies count]], equalTo([NSNumber numberWithInt:1]));
}

- (void) tearDown {
    
}

@end