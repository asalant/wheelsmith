#import "WheelDetailController.h"
#import "TableCellFactory.h"
#import "LabeledValueCell.h"

@implementation WheelDetailController

@synthesize wheel;
@synthesize rimDetailController, hubDetailController, rimBrandsController, hubBrandsController, delegate;

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
        
        patternPickerOptions = [[NSDictionary dictionaryWithObjectsAndKeys:
                                @"radial", [NSNumber numberWithInt:0], 
                                 @"3 across", [NSNumber numberWithInt:3], 
                                 @"4 across", [NSNumber numberWithInt:4], 
                                 nil] retain];
        spokePatternPicker = [[[CheckmarkPickerController alloc] initWithStyle:UITableViewStyleGrouped] retain];
        spokePatternPicker.title = @"Spoke Pattern";
        spokePatternPicker.delegate = self;
        spokePatternPicker.options = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], nil];
        spokePatternPicker.selectedIndex = [NSNumber numberWithInt:1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!wheel.pk) {
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                               target:self 
                                                                                               action:@selector(dismissModal)] autorelease];
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                                target:self 
                                                                                                action:@selector(saveWheel)] autorelease];
    }
    [self updateView];
    
}

#pragma mark New Wheel controls

- (void) dismissModal {
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    [self dismissModalViewControllerAnimated:YES];
}


- (void) saveWheel {
    [self.wheel create];
    [self dismissModal];
    [delegate afterCreateWheel:self.wheel];
}

#pragma mark EditWheelDelegate methods

-(void)setHub:(Hub *)hub {
    self.wheel.hub = hub;
    [self.navigationController popToViewController:self animated:YES];
    [self afterEditWheel:self.wheel];
}

-(void)setRim:(Rim *)rim {
    self.wheel.rim = rim;
    [self.navigationController popToViewController:self animated:YES];
    [self afterEditWheel:self.wheel];
}

-(void)setSpokePattern:(NSNumber *)across {
    wheel.spokePattern = across;
    [self afterEditWheel:self.wheel];
}


-(void)afterEditWheel:(Wheel *)theWheel {
    if (theWheel.pk) {
        [theWheel update];
        [self.delegate afterUpdateWheel:theWheel];
    }
    
}

- (void) updateView {
    [rimCell setValue:wheel.rim ? wheel.rim.description : @"Choose Rim"];
    [hubCell setValue:wheel.hub ? wheel.hub.description : @"Choose Hub"];
    [spokePatternCell setValue:wheel.spokePattern ? wheel.spokePatternDescription : @"Choose Pattern"];
    
    [leftLengthCell setValue:[NSString stringWithFormat:@"%@mm  ", [wheel leftSpokeLength]]];
    [rightLengthCell setValue:[NSString stringWithFormat:@"%@mm  ", [wheel rightSpokeLength]]];
    
    [self.tableView reloadData];
}

#pragma mark CheckmarkPickerDelegate methods
-(NSString *)labelForOption:(id)option {
    return [patternPickerOptions objectForKey:option];
}

-(void)optionSelected:(id)option {
    [self setSpokePattern:option];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!wheel.isValid) {
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
        hubDetailController.editWheelDelegate = self;
        hubBrandsController.holeCount = wheel.rim.holeCount;
        hubBrandsController.brands = [Hub selectBrandNamesForHoleCount:wheel.rim.holeCount];
        if (wheel.hub) {
            hubDetailController.hub = wheel.hub;
            [self.navigationController pushViewController:hubBrandsController animated:NO];
            [self.navigationController pushViewController:hubDetailController animated:YES];
        }
        else {
            [self.navigationController pushViewController:hubBrandsController animated:YES];
        }
    }
    else if (cell == rimCell) {
        rimDetailController.editWheelDelegate = self;
        rimBrandsController.holeCount = wheel.hub.holeCount;
        rimBrandsController.brands = [Rim selectBrandNamesForHoleCount:wheel.hub.holeCount];
        if (wheel.rim) {
            rimDetailController.rim = wheel.rim;
            [self.navigationController pushViewController:rimBrandsController animated:NO];
            [self.navigationController pushViewController:rimDetailController animated:YES];
        }
        else {
            [self.navigationController pushViewController:rimBrandsController animated:YES];
        }
    }
    else if (cell == spokePatternCell) {
        spokePatternPicker.selectedOption = self.wheel.spokePattern;
        [self.navigationController pushViewController:spokePatternPicker animated:YES];
    }
}


- (void)dealloc {
    [wheel release];
    [sections release];
    [hubDetailController release];
    [rimDetailController release];
    [rimBrandsController release];
    [hubBrandsController release];
    [patternPickerOptions release];
    [super dealloc];
}


@end

