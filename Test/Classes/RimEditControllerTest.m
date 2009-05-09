#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>
#import "OCMockConstraint+Extensions.h"
#import "UIViewController+Testable.h"

#import "RimEditController.h"
#import "Rim.h"

@interface RimEditControllerTest : SenTestCase {}
    RimEditController *controller;
@end

@implementation RimEditControllerTest

-(void) setUp {
    controller = [[RimEditController alloc] initWithNibName:@"RimEditView" bundle:nil];
    [controller loadView];
}

- (void) testErdFormatting {
    Rim *rim = [[[Rim alloc] init] autorelease];
    rim.erd = [NSNumber numberWithDouble:605.0];
    rim.offset = [NSNumber numberWithDouble:0.0];
    rim.size = [NSNumber numberWithInt:622];
    rim.holeCount = [NSNumber numberWithInt:32];
    
    controller.rim = rim;
    [controller viewDidLoad];
    
    assertThat(controller.erdTextField.text, equalTo(@"605.0"));
    assertThat(controller.offsetTextField.text, equalTo(@"0.0"));
    assertThat(controller.holeCountTextField.text, equalTo(@"32"));
}

@end
