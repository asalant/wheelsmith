#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>
#import "OCMockConstraint+Extensions.h"
#import "UIViewController+Testable.h"

#import "LabeledValueCell.h"
#import "RimDetailController.h"
#import "Rim.h"

@interface RimDetailControllerTest : SenTestCase {}
RimDetailController *controller;
-(LabeledValueCell *)cellForRow:(int)row inSection:(int)section;
@end

@implementation RimDetailControllerTest

-(void) setUp {
    Rim *rim = [[[Rim alloc] init] autorelease];
    rim.brand = @"Mavic";
    rim.description = @"Open Pro";
    rim.holeCount = [NSNumber numberWithInt:32];
    rim.erd = [NSNumber numberWithDouble:605.0];
    rim.offset = [NSNumber numberWithDouble:0.5];
    rim.size = [NSNumber numberWithInt:622];
    
    controller = [[[RimDetailController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    controller.rim = rim;
    
    [controller loadView];
    [controller viewWillAppear:NO];
}

-(void) testInitializesForExistingRim {
    assertThat([NSNumber numberWithInt:[controller numberOfSectionsInTableView:nil]], 
               is([NSNumber numberWithInt:3]));
    
    assertThat([self cellForRow:0 inSection:0].detailTextLabel.text, is(@"Mavic"));
    assertThat([self cellForRow:1 inSection:0].detailTextLabel.text, is(@"Open Pro"));;
    assertThat([self cellForRow:2 inSection:0].detailTextLabel.text, is(@"32 holes, 700c"));
    
    assertThat([self cellForRow:0 inSection:1].textLabel.text, is(@"ERD"));
    assertThat([self cellForRow:0 inSection:1].detailTextLabel.text, is(@"605.0 mm"));
    
    assertThat([self cellForRow:0 inSection:2].textLabel.text, is(@"Offset"));
    assertThat([self cellForRow:0 inSection:2].detailTextLabel.text, is(@"0.5 mm"));
}

-(LabeledValueCell *)cellForRow:(int)row inSection:(int)section {
    return (LabeledValueCell *)[controller tableView:nil cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

@end
