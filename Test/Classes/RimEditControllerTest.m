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
    [controller viewWillAppear:YES];
    
    assertThat(controller.erdTextField.text, equalTo(@"605.0"));
    assertThat(controller.offsetTextField.text, equalTo(@"0.0"));
    assertThat(controller.holeCountTextField.text, equalTo(@"32"));
}

-(void)testSavesRimWithInput {
    Rim *rim = [[[Rim alloc] init] autorelease];
    
    controller.rim = rim;
    [controller viewWillAppear:YES];
    
    controller.brandTextField.text = @"Brand";
    controller.descriptionTextField.text = @"Description";
    controller.sizeTextField.text = @"700";
    controller.holeCountTextField.text = @"32";
    controller.erdTextField.text = @"605";
    controller.offsetTextField.text = @"0.0";
    
    [controller saveRim];
    
    assertThat(rim.pk, notNilValue());
    assertThat(rim.brand, is(@"Brand"));
    assertThat(rim.description, is(@"Description"));
    assertThat(rim.size, is([NSNumber numberWithInt:700]));
    assertThat(rim.holeCount, is([NSNumber numberWithInt:32]));
    assertThat(rim.erd, is([NSNumber numberWithDouble:605.0]));
    assertThat(rim.offset, is([NSNumber numberWithDouble:0.0]));
}

@end
