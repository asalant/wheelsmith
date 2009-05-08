#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>
#import "OCMockConstraint+Extensions.h"
#import "UIViewController+Testable.h"

#import "DomainObject.h"
#import "WheelDetailController.h"
#import "Wheel.h"

@interface WheelDetailControllerTest : SenTestCase {}
    WheelDetailController *controller;
@end

@implementation WheelDetailControllerTest

-(void) setUp {
	[DomainObject setDatabase:[Database create:@"test" overwrite:YES]];
    controller = [[[WheelDetailController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    [controller loadView];
    [controller viewDidLoad];
}

-(void) testRendersForNewWheel {
    controller.wheel = [[[Wheel alloc] init] autorelease];
    [controller viewWillAppear:NO];
    
    assertThat([NSNumber numberWithInt:[controller numberOfSectionsInTableView:nil]], 
               is([NSNumber numberWithInt:2]));
    
    assertThat([((LabeledValueCell *)[controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).valueLabel text],
               is(@"Choose Hub"));
    assertThat([((LabeledValueCell *)[controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).valueLabel text],
               is(@"Choose Rim"));
    
    assertThat([((LabeledValueCell *)[controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]]).valueLabel text],
               is(@"Choose Pattern"));
}

-(void) testRendersForExistingWheel {
    controller.wheel = [[Wheel findAllOrderBy:@"created_at desc"] objectAtIndex:0];
    [controller viewWillAppear:NO];
    
    assertThat([((LabeledValueCell *)[controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).valueLabel text],
               is(@"Campagnolo Record Front 32h Black"));
}

@end
