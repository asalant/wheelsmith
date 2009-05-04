#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>
#import "OCMockConstraint+Extensions.h"
#import "UIViewController+Testable.h"

#import "HubDetailController.h"
#import "Hub.h"

@interface HubDetailControllerTest : SenTestCase {}
    HubDetailController *controller;
@end

@implementation HubDetailControllerTest

-(void) setUp {
    Hub *hub = [[[Hub alloc] init] autorelease];
    hub.holeCount = [NSNumber numberWithInt:32];
    controller = [[[HubDetailController alloc] initWithNibName:@"HubDetailView" bundle:nil] autorelease];
    controller.hub = hub;
    [controller loadView];
    [controller viewDidLoad];
}

-(void) testInitializesValues {
    assertThat(controller.holeCountLabel.text, is(@"32 holes"));
}

@end
