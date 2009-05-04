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
        spokeCountCell = [LabeledValueCell createCellWithLabel:@"Spoke Count"  withValue:@""];    
        spokePatternCell = [LabeledValueCell createCellWithLabel:@"Spoke Pattern"  withValue:@""];
        leftLengthCell = [LabeledValueCell createCellWithLabel:@"Left Spoke Length" withValue:@""];
        rightLengthCell = [LabeledValueCell createCellWithLabel:@"Right Spoke Length" withValue:@""];
        
        sections = [[NSArray arrayWithObjects:
                     [NSArray arrayWithObjects:hubCell, rimCell, nil],
                     [NSArray arrayWithObjects:spokeCountCell, spokePatternCell, nil],
                     [NSArray arrayWithObjects:leftLengthCell, rightLengthCell, nil],
                     nil] retain];
        
        spokeCountPicker = [[[PickerController alloc] initWithNibName:@"PickerView" bundle:nil] retain];
        spokeCountPicker.target = self;
        spokeCountPicker.handler = @selector(spokeCountPicked:);
        {
            NSMutableArray *options = [NSMutableArray arrayWithCapacity:20];
            int i;
            for (i = 12; i <= 100; i += 4) {
                [options addObject:[NSNumber numberWithInt:i]];
            }
            spokeCountPicker.options = options;
            spokeCountPicker.selectedOption = [NSNumber numberWithInt:32];
        }
        
        spokePatternPicker = [[[PickerController alloc] initWithNibName:@"PickerView" bundle:nil] retain];
        spokePatternPicker.target = self;
        spokePatternPicker.handler = @selector(spokePatternPicked:);
        {
            NSMutableArray *options = [NSMutableArray arrayWithCapacity:20];
            int i;
            for (i = 0; i <= 6; i++) {
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
    
    [rimCell setValue:[NSString stringWithFormat:@"%@ %@", wheel.rim.brand, wheel.rim.description]];
    [hubCell setValue:[NSString stringWithFormat:@"%@ %@", wheel.hub.brand, wheel.hub.description]];
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

- (void) spokeCountPicked:(NSNumber *)item {
    [self recalculate];
}

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
    return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
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

