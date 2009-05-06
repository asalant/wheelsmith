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
    NSArray *hubs = [Hub findAllOrderBy:nil];
    assertThat([NSNumber numberWithInt:hubs.count], equalTo([NSNumber numberWithInt:2]));
}

- (void) testHydratesHub {
    Hub *hub = [[Hub findAllOrderBy:@"brand"] objectAtIndex:1];
    assertThat(hub.brand, equalTo(@"Chris King"));
    assertThat(hub.rear, is([NSNumber numberWithBool:YES]));
}

- (void) testSelectsBrandNames {
    NSArray *companies = [Hub selectBrandNames];
    assertThat([NSNumber numberWithInt:[companies count]], equalTo([NSNumber numberWithInt:2]));
}

@end