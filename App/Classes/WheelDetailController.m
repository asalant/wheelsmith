#import "WheelDetailController.h"
#import "TableCellFactory.h"
#import "LabeledValueCell.h"
#import "PickerController.h"

@implementation WheelDetailController

@synthesize wheel;
@synthesize rimDetailController, hubDetailController;

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        self.title = @"Wheel Build";
        
        rimCell = [LabeledValueCell createCellWithLabel:@"Rim"  withValue:@""];
        hubCell = [LabeledValueCell createCellWithLabel:@"Hub"  withValue:@""];       
        spokePatternCell = [LabeledValueCell createCellWithLabel:@"Spoke Pattern"  withValue:@""];
        leftLengthCell = [LabeledValueCell createCellWithLabel:@"Left Spoke Length" withValue:@""];
        rightLengthCell = [LabeledValueCell createCellWithLabel:@"Right Spoke Length" withValue:@""];
        
        sections = [[NSArray arrayWithObjects:
                     [NSArray arrayWithObjects:hubCell, rimCell, nil],
                     [NSArray arrayWithObjects:spokePatternCell, nil],
                     [NSArray arrayWithObjects:leftLengthCell, rightLengthCell, nil],
                     nil] retain];
        
        spokePatternPicker = [[[PickerController alloc] initWithNibName:@"PickerView" bundle:nil] retain];
        spokePatternPicker.target = self;
        spokePatternPicker.handler = @selector(spokePatternPicked:);
        {
            NSMutableArray *options = [NSMutableArray arrayWithCapacity:20];
            int i;
            for (i = 0; i <= 4; i++) {
                [options addObject:[NSNumber numberWithInt:i]];
            }
            spokePatternPicker.options = options;
            spokePatternPicker.selectedOption = [NSNumber numberWithInt:3];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [rimCell setValue:wheel.rim.description];
    [hubCell setValue:wheel.hub.description];
    [spokePatternCell setValue:wheel.spokePatternDescription];
    
    [self recalculate];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Handlers for editing views

- (void) spokePatternPicked:(NSNumber *)item {
    wheel.spokePattern = item;
    [spokePatternCell setValue:wheel.spokePatternDescription];
    [self recalculate];
}

- (void) recalculate {
    [leftLengthCell setValue:[NSString stringWithFormat:@"%@mm  ", [wheel leftSpokeLength]]];
    [rightLengthCell setValue:[NSString stringWithFormat:@"%@mm  ", [wheel rightSpokeLength]]];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sections.count;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[sections objectAtIndex:section] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section != 2 ) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (cell == hubCell) {
        hubDetailController.hub = wheel.hub;
        [hubDetailController viewDidLoad];
        [self.navigationController pushViewController:hubDetailController animated:YES];
    }
    else if (cell == rimCell) {
        rimDetailController.rim = wheel.rim;
        [rimDetailController viewDidLoad];
        [self.navigationController pushViewController:rimDetailController animated:YES];
    }
    else if (cell == spokeCountCell) {
        [self presentModalViewController:spokeCountPicker animated:YES];
    }
    else if (cell == spokePatternCell) {
        [self presentModalViewController:spokePatternPicker animated:YES];
    }
}


- (void)dealloc {
    [wheel release];
    [sections release];
    [hubDetailController release];
    [rimDetailController release];
    [spokeCountPicker release];
    [super dealloc];
}


@end

