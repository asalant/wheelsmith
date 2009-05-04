#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>
#import "OCMockConstraint+Extensions.h"
#import "UIViewController+Testable.h"

#import "RimDetailController.h"
#import "Rim.h"

@interface RimDetailControllerTest : SenTestCase {}
    RimDetailController *controller;
@end

@implementation RimDetailControllerTest

-(void) setUp {
    controller = [[RimDetailController alloc] initWithNibName:@"RimDetailView" bundle:nil];
    [controller loadView];
}

- (void) testErdFormatting {
    Rim *rim = [[[Rim alloc] init] autorelease];
    rim.erd = [NSNumber numberWithDouble:605.0];
    rim.offset = [NSNumber numberWithDouble:0.0];
    rim.size = [NSNumber numberWithInt:622];
    
    controller.rim = rim;
    [controller viewDidLoad];
    
    assertThat(controller.erdLabel.text, equalTo(@"605.0"));
    assertThat(controller.offsetLabel.text, equalTo(@"0.0"));
}

@end
