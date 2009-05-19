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
	[DomainObject setDatabase:[Database create:@"test" overwrite:YES]];
}

- (void) testFindsAllHubs {
    NSArray *hubs = [Hub findAllOrderBy:nil];
    assertThat([NSNumber numberWithInt:hubs.count], equalTo([NSNumber numberWithInt:2]));
}

- (void) testHydratesHub {
    Hub *hub = [[Hub findAllOrderBy:@"brand"] objectAtIndex:1];
    assertThat(hub.brand, equalTo(@"Chris King"));
    assertThat(hub.rear, is([NSNumber numberWithBool:YES]));
    assertThat(hub.verified, is([NSNumber numberWithBool:YES]));
}

- (void) testSelectsBrandNames {
    NSArray *companies = [Hub selectBrandNames];
    assertThat([NSNumber numberWithInt:[companies count]], equalTo([NSNumber numberWithInt:2]));
    assertThat([companies objectAtIndex:0], is(@"Campagnolo"));
    assertThat([companies objectAtIndex:1], is(@"Chris King")); 
}

- (void) testSelectsBrandNamesForHoleCount {
    NSArray *companies = [Hub selectBrandNamesForHoleCount:[NSNumber numberWithInt:28]];
    assertThat([NSNumber numberWithInt:[companies count]], equalTo([NSNumber numberWithInt:1]));
    assertThat([companies objectAtIndex:0], is(@"Chris King")); 
}

- (void) testSelectsBrandNamesForNilHoleCount {
    NSArray *companies = [Hub selectBrandNamesForHoleCount:nil];
    assertThat([NSNumber numberWithInt:[companies count]], equalTo([NSNumber numberWithInt:2]));
}

-(void)testCreatesHub {
    Hub *hub = [[[Hub alloc] init] autorelease];
    hub.brand = @"Brand";
    hub.rear = [NSNumber numberWithBool:YES];
    [hub create];
    assertThat(hub.pk, notNilValue());
    
    Hub *created = [Hub find:hub.pk];
    assertThat(created.rear, is(hub.rear));
}

@end