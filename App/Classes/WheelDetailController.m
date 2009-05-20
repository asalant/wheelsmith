#import "WheelDetailController.h"
#import "TableCellFactory.h"
#import "LabeledValueCell.h"

@implementation WheelDetailController

@synthesize wheel, editing;
@synthesize rimDetailController, hubDetailController, rimBrandsController, hubBrandsController, delegate;

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        
        rimCell = [LabeledValueCell createCellWithLabel:@"Rim"  withValue:@""];
        hubCell = [LabeledValueCell createCellWithLabel:@"Hub"  withValue:@""];       
        spokePatternCell = [LabeledValueCell createCellWithLabel:@"Spoke Pattern"  withValue:@""];
        leftLengthCell = [LabeledValueCell createCellWithLabel:@"Left Spoke Length" withValue:@""];
        leftLengthCell.selectionStyle = UITableViewCellSelectionStyleNone;
        rightLengthCell = [LabeledValueCell createCellWithLabel:@"Right Spoke Length" withValue:@""];
        rightLengthCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (editing) {
        [self enableEdit];
    }
    else {
        [self disableEdit];
    }
    [self updateView];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[self disableEdit];
}

- (void) enableEdit {
    self.editing = YES;
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                           target:self 
                                                                                           action:@selector(cancelEdit)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                            target:self 
                                                                                            action:@selector(saveWheel)] autorelease];
    hubCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    rimCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    spokePatternCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    spokePatternCell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    [self.tableView reloadData];
}

- (void) disableEdit {
    self.editing = false;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                            target:self 
                                                                                            action:@selector(enableEdit)] autorelease];
    hubCell.accessoryType = UITableViewCellAccessoryNone;
    hubCell.selectionStyle = wheel.hub ? UITableViewCellSelectionStyleBlue : UITableViewCellSelectionStyleNone;
    rimCell.accessoryType = UITableViewCellAccessoryNone;
    rimCell.selectionStyle = wheel.rim ? UITableViewCellSelectionStyleBlue : UITableViewCellSelectionStyleNone;
    spokePatternCell.accessoryType = UITableViewCellAccessoryNone;
    spokePatternCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.tableView reloadData];
}

#pragma mark New Wheel controls

- (void) cancelEdit {
    if (wheel.pk) {
        [wheel revert];
        [self updateView];
        [self disableEdit];
    }
    else {
        [self dismissModalViewControllerAnimated:YES];
    }
}


- (void) saveWheel {
    if (!wheel.pk) {
        [self.wheel create];
        [delegate afterCreateWheel:self.wheel];
        [self dismissModalViewControllerAnimated:YES];
    }
    else {
        [wheel update];
        [delegate afterUpdateWheel:wheel];
        [self disableEdit];
    }
}

#pragma mark EditWheelDelegate methods

-(void)setHub:(Hub *)hub {
    self.wheel.hub = hub;
    [self.navigationController popToViewController:self animated:YES];
}

-(void)setRim:(Rim *)rim {
    self.wheel.rim = rim;
    [self.navigationController popToViewController:self animated:YES];
}

-(void)setSpokePattern:(NSNumber *)across {
    wheel.spokePattern = across;
}

- (void) updateView {
    [rimCell setValue:wheel.rim ? [NSString stringWithFormat:@"%@ %@",wheel.rim.brand, wheel.rim.description] : @"Choose Rim"];
    [hubCell setValue:wheel.hub ? [NSString stringWithFormat:@"%@ %@",wheel.hub.brand, wheel.hub.description] : @"Choose Hub"];
    [spokePatternCell setValue:wheel.spokePattern ? wheel.spokePatternDescription : @"Choose Pattern"];
    
    [leftLengthCell setValue:[NSString stringWithFormat:@"%@mm", [wheel leftSpokeLength]]];
    [rightLengthCell setValue:[NSString stringWithFormat:@"%@mm", [wheel rightSpokeLength]]];
    
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
    if (editing || !wheel.isValid) {
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
//    if (editing)
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    else
//        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (cell == hubCell) {
        hubDetailController.editWheelDelegate = self;
        if (editing) {
            hubBrandsController.holeCount = wheel.rim.holeCount;
            hubBrandsController.brands = [Hub selectBrandNamesForHoleCount:wheel.rim.holeCount];
            [self.navigationController pushViewController:hubBrandsController animated:YES];
        }
        else if (wheel.hub) {
            hubDetailController.hub = wheel.hub;
            [self.navigationController pushViewController:hubDetailController animated:YES];
        }
    }
    else if (cell == rimCell) {
        rimDetailController.editWheelDelegate = self;
        if (editing) {
            rimDetailController.canChoosePart = YES;
            rimBrandsController.holeCount = wheel.hub.holeCount;
            rimBrandsController.brands = [Rim selectBrandNamesForHoleCount:wheel.hub.holeCount];
            [self.navigationController pushViewController:rimBrandsController animated:YES];
        }
        else if (wheel.rim) {
            rimDetailController.rim = wheel.rim;
            rimDetailController.canChoosePart = NO;
            [self.navigationController pushViewController:rimDetailController animated:YES];
        }
    }
    else if (cell == spokePatternCell && editing) {
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

