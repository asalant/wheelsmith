#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>
#import "OCMockConstraint+Extensions.h"
#import "UIViewController+Testable.h"

#import "WheelDetailController.h"
#import "HubDetailController.h"
#import "Hub.h"
#import "Wheel.h"

@interface HubDetailControllerTest : SenTestCase {}
    HubDetailController *controller;
    WheelDetailController *wheelDetailController;
@end

@implementation HubDetailControllerTest

-(void) setUp {
    Hub *hub = [[[Hub alloc] init] autorelease];
    hub.brand = @"Campagnolo";
    hub.description = @"Record";
    hub.holeCount = [NSNumber numberWithInt:32];
    controller = [[[HubDetailController alloc] initWithNibName:@"HubDetailView" bundle:nil] autorelease];
    controller.hub = hub;
    [controller loadView];
    [controller viewDidLoad];
    
    wheelDetailController = [[[WheelDetailController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    wheelDetailController.wheel = [[[Wheel alloc] init] autorelease];
    [wheelDetailController loadView];
    [wheelDetailController viewDidLoad];
    controller.editWheelDelegate = wheelDetailController;
}

-(void) testInitializesValues {
    assertThat(controller.holeCountLabel.text, is(@"32 holes"));
}

-(void)testChoosesHub {
    [controller chooseHub];
    assertThat(wheelDetailController.wheel.hub, is(controller.hub));
}

@end
