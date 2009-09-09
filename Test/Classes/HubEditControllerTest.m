#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>
#import "OCMockConstraint+Extensions.h"
#import "UIViewController+Testable.h"

#import "HubEditController.h"
#import "Hub.h"

@interface HubEditControllerTest : SenTestCase {}
    HubEditController *controller;
@end

@implementation HubEditControllerTest

-(void) setUp {
    controller = [[HubEditController alloc] initWithNibName:@"HubEditView" bundle:nil];
    [controller loadView];
}

- (void) testFormatsValues {
    Hub *hub = [[[Hub alloc] init] autorelease];
    hub.rear = [NSNumber numberWithBool:YES];
    hub.holeCount = [NSNumber numberWithInt:32];
    hub.leftFlangeDiameter = [NSNumber numberWithDouble:44.0];
    hub.leftFlangeToCenter = [NSNumber numberWithDouble:36.0];
    hub.rightFlangeDiameter = [NSNumber numberWithDouble:46.0];
    hub.rightFlangeToCenter = [NSNumber numberWithDouble:17.0];
    
    controller.hub = hub;
    [controller viewWillAppear:YES];
    
    assertThat(controller.leftFlangeDiameterTextField.text, equalTo(@"44.0"));
    assertThat(controller.leftFlangeToCenterTextField.text, equalTo(@"36.0"));
    assertThat(controller.rightFlangeDiameterTextField.text, equalTo(@"46.0"));
    assertThat(controller.rightFlangeToCenterTextField.text, equalTo(@"17.0"));
}

-(void)testSavesHubWithInput {
    Hub *hub = [[[Hub alloc] init] autorelease];
    
    controller.hub = hub;
    [controller viewWillAppear:YES];
    
    controller.brandTextField.text = @"Brand";
    controller.descriptionTextField.text = @"Description";
    controller.holeCountTextField.text = @"32";
    controller.rearSwitch.on = YES;
    
    [controller saveHub];
    
    assertThat(hub.pk, notNilValue());
    assertThat(hub.brand, is(@"Brand"));
    assertThat(hub.description, is(@"Description"));
    assertThat(hub.rear, is([NSNumber numberWithBool:YES]));
    assertThat(hub.holeCount, is([NSNumber numberWithInt:32]));
}

@end
