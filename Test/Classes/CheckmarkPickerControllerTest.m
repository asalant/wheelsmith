#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>
#import "OCMockConstraint+Extensions.h"
#import "UIViewController+Testable.h"

#import "CheckmarkPickerController.h"

@interface CheckmarkPickerControllerTest : SenTestCase <CheckmarkPickerDelegate> {}
    CheckmarkPickerController *controller;
@end

@implementation CheckmarkPickerControllerTest

-(void) setUp {
    controller = [[[CheckmarkPickerController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    controller.options = [NSArray arrayWithObjects:@"radial", @"3 across", @"4 across", nil];
    controller.delegate = self;
    [controller loadView];
}

-(void) testNothingSelected {
    assertThat(controller.selectedIndex, nilValue());
    assertThat(controller.selectedOption, nilValue());
}

-(void) testSelectsObjectAtIndex {
    controller.selectedIndex = [NSNumber numberWithInt:0];
    assertThat(controller.selectedOption, is(@"radial"));
}

-(void) testSelectsOption {
    controller.selectedOption = @"3 across";
    assertThat(controller.selectedIndex, is([NSNumber numberWithInt:1]));
}

-(void) testNoSelectionForNonexistentOption {
    controller.selectedIndex = [NSNumber numberWithInt:1];
    controller.selectedOption = @"foo";
    assertThat(controller.selectedIndex, nilValue());
}

-(void)testShowsNoCheckmarkForNotSelectedIndex {
    controller.selectedIndex = [NSNumber numberWithInt:0];
    UITableViewCell *cell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    assertThat([NSNumber numberWithInt:cell.accessoryType], 
               is([NSNumber numberWithInt:UITableViewCellAccessoryNone]));
}

-(void)testShowsCheckmarkForSelectedIndex {
    controller.selectedIndex = [NSNumber numberWithInt:0];
    UITableViewCell *cell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    assertThat([NSNumber numberWithInt:cell.accessoryType], 
               is([NSNumber numberWithInt:UITableViewCellAccessoryCheckmark]));
}

-(void)testSelectsRow {
    [controller tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    assertThat(controller.selectedIndex, is([NSNumber numberWithInt:1]));
}

#pragma mark CheckmarkPickerDelegate methods

-(void)optionSelected:(id)option {
    
}

-(NSString *)labelForOption:(id)option {
    return option;
}

@end
