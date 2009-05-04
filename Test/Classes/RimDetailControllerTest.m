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
    controller.brandLabel = [[UILabel alloc] init];
    controller.descriptionLabel  = [[UILabel alloc] init];
    controller.erdLabel  = [[UILabel alloc] init];
    controller.offsetLabel  = [[UILabel alloc] init];
    controller.isoLabel  = [[UILabel alloc] init];
    controller.sizeLabel  = [[UILabel alloc] init];
    controller.verifiedLabel  = [[UILabel alloc] init];
    controller.notesTextView = [[UITextView alloc] init];
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
