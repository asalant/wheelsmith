#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>
#import "OCMockConstraint+Extensions.h"
#import "UIViewController+Testable.h"

#import "DomainObject.h"
#import "MyWheelsController.h"
#import "Wheel.h"

@interface MyWheelsControllerTest : SenTestCase {}
    MyWheelsController *controller;
@end

@implementation MyWheelsControllerTest

-(void) setUp {
	[DomainObject setDatabase:[Database create:@"test" overwrite:YES]];
    controller = [[[MyWheelsController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    controller.wheels = [NSMutableArray arrayWithArray:[Wheel findAllOrderBy:nil]];
    [controller loadView];
}

-(void) testFormatsWheelCell {
    LabeledValueCell *cell = (LabeledValueCell *)[controller tableView:0 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    assertThat(cell, notNilValue());
    assertThat(cell.valueLabel.text, is(@"radial"));
}

@end
