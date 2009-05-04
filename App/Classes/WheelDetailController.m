#import "WheelDetailController.h"
#import "TableCellFactory.h"
#import "LabeledValueCell.h"
#import "PickerController.h"

@implementation WheelDetailController

@synthesize wheel;
@synthesize rimDetailController, hubDetailController, rimBrandsController, hubBrandsController;

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
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    [rimCell setValue:wheel.rim ? wheel.rim.description : @"Choose Rim"];
    [hubCell setValue:wheel.hub ? wheel.hub.description : @"Choose Hub"];
    [spokePatternCell setValue:wheel.spokePattern ? wheel.spokePatternDescription : @"Choose Pattern"];
    
    [self recalculate];
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
    if (!wheel.hub || !wheel.rim || !wheel.spokePattern) {
        return sections.count - 1;
    }
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
        if (wheel.hub) {
            hubDetailController.hub = wheel.hub;
            [self.navigationController pushViewController:hubDetailController animated:YES];
        }
        else {
            [self.navigationController pushViewController:hubBrandsController animated:YES];
        }
    }
    else if (cell == rimCell) {
        if (wheel.rim) {
            rimDetailController.rim = wheel.rim;
            [self.navigationController pushViewController:rimDetailController animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:rimBrandsController animated:YES];
        }
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
    [rimBrandsController release];
    [hubBrandsController release];
    [super dealloc];
}


@end

