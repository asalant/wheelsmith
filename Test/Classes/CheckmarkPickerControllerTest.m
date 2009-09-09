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
    controller.options = [NSArray arrayWithObjects:@"radial", @"3 cross", @"4 cross", nil];
    controller.delegate = self;
    controller.selectedIndex = -1;
    [controller loadView];
}

-(void) testNothingSelected {
    assertThat([NSNumber numberWithInt:controller.selectedIndex], is([NSNumber numberWithInt:-1]));
    assertThat(controller.selectedOption, nilValue());
}

-(void) testSelectsObjectAtIndex {
    controller.selectedIndex = 0;
    assertThat(controller.selectedOption, is(@"radial"));
}

-(void) testSelectsNothingAtInvalidIndex {
    controller.selectedIndex = -1;
    assertThat(controller.selectedOption, nilValue());
    controller.selectedIndex = 6;
    assertThat(controller.selectedOption, nilValue());
}

-(void)testShowsNoCheckmarkForNotSelectedIndex {
    controller.selectedIndex = 0;
    UITableViewCell *cell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    assertThat([NSNumber numberWithInt:cell.accessoryType], 
               is([NSNumber numberWithInt:UITableViewCellAccessoryNone]));
}

-(void)testShowsCheckmarkForSelectedIndex {
    controller.selectedIndex = 0;
    UITableViewCell *cell = [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    assertThat([NSNumber numberWithInt:cell.accessoryType], 
               is([NSNumber numberWithInt:UITableViewCellAccessoryCheckmark]));
}

-(void)testDeselectsPreviewRowWhenSelectingAnother {
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [controller tableView:nil didSelectRowAtIndexPath:firstIndexPath];
    assertThat([NSNumber numberWithInt:controller.selectedIndex], is([NSNumber numberWithInt:firstIndexPath.row]));
    assertThat([NSNumber numberWithInt:[controller tableView:nil cellForRowAtIndexPath:firstIndexPath].accessoryType], 
               is([NSNumber numberWithInt:UITableViewCellAccessoryCheckmark]));
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [controller tableView:nil didSelectRowAtIndexPath:nextIndexPath];
    assertThat([NSNumber numberWithInt:[controller tableView:nil cellForRowAtIndexPath:firstIndexPath].accessoryType], 
               is([NSNumber numberWithInt:UITableViewCellAccessoryNone]));
}

-(void)testNumbersAsOptions {
    controller = [[[CheckmarkPickerController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    controller.options = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], nil];
    controller.delegate = self;
    [controller loadView];
    [controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

#pragma mark CheckmarkPickerDelegate methods

-(void)optionSelected:(id)option {
    
}

-(NSString *)labelForOption:(id)option {
    return [option description];
}

@end
