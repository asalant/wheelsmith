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

    -(LabeledValueCell *)cellForRow:(int)row inSection:(int)section;
@end

@implementation HubDetailControllerTest

-(void) setUp {
    Hub *hub = [[[Hub alloc] init] autorelease];
    hub.pk = [NSNumber numberWithInt:1];
    hub.brand = @"Campagnolo";
    hub.description = @"Record";
    hub.holeCount = [NSNumber numberWithInt:32];
    hub.leftFlangeDiameter = [NSNumber numberWithDouble:40.5];
    
    controller = [[[HubDetailController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    controller.hub = hub;
    [controller loadView];
    [controller viewWillAppear:NO];
    
    wheelDetailController = [[[WheelDetailController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    wheelDetailController.wheel = [[[Wheel alloc] init] autorelease];
    [wheelDetailController loadView];
    [wheelDetailController viewDidLoad];
    controller.editWheelDelegate = wheelDetailController;
}

-(void) testInitializesForExistingHub {
    assertThat([NSNumber numberWithInt:[controller numberOfSectionsInTableView:nil]], 
               is([NSNumber numberWithInt:3]));

    assertThat([self cellForRow:0 inSection:0].detailTextLabel.text, is(@"Campagnolo"));
    assertThat([self cellForRow:1 inSection:0].detailTextLabel.text, is(@"Record"));;
    assertThat([self cellForRow:2 inSection:0].detailTextLabel.text, is(@"32 holes, front"));
    
    assertThat([self cellForRow:0 inSection:1].textLabel.text, is(@"Diameter"));
    assertThat([self cellForRow:0 inSection:1].detailTextLabel.text, is(@"40.5 mm"));
    assertThat([self cellForRow:1 inSection:1].textLabel.text, is(@"To Center"));
    
    assertThat([self cellForRow:0 inSection:2].textLabel.text, is(@"Diameter"));
    assertThat([self cellForRow:1 inSection:2].textLabel.text, is(@"To Center"));
}

-(LabeledValueCell *)cellForRow:(int)row inSection:(int)section {
    return (LabeledValueCell *)[controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

-(void)testChoosesHub {
    [controller chooseHub];
    assertThat(wheelDetailController.wheel.hub, is(controller.hub));
}

-(void)testCantChoosePart {
    assertThat(controller.navigationItem.rightBarButtonItem, nilValue());
}

-(void)testCanChoosePart {
    controller.canChoosePart = YES;
    [controller viewWillAppear:NO];
    assertThat(controller.navigationItem.rightBarButtonItem, notNilValue());
    
    controller.canChoosePart = NO;
    [controller viewWillAppear:NO];
    assertThat(controller.navigationItem.rightBarButtonItem, nilValue());
}

@end
