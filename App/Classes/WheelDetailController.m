#import "AppDefines.h"
#import "WheelDetailController.h"
#import "TableCellFactory.h"
#import "LabeledValueCell.h"
#import "FlurryAPI.h"
#import "WheelEmail.h"
#import "ButtonCell.h"
#import "PatternPickerDelegate.h"

@implementation WheelDetailController

@synthesize wheel, editing;
@synthesize rimDetailController, hubDetailController, rimBrandsController, hubBrandsController, delegate;

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        
        rimCell = [LabeledValueCell createCellWithLabel:@"Rim"];
        hubCell = [LabeledValueCell createCellWithLabel:@"Hub"];       
        spokePatternCell = [LabeledValueCell createCellWithLabel:@"Pattern"];
        leftLengthCell = [LabeledValueCell createCellWithLabel:@"Left"];
        leftLengthCell.selectionStyle = UITableViewCellSelectionStyleNone;
        rightLengthCell = [LabeledValueCell createCellWithLabel:@"Right"];
        rightLengthCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        sendEmailCell = [ButtonCell cellWithLabel:@"Send Email"];
        
        sections = [[NSArray arrayWithObjects:
                     [NSArray arrayWithObjects:hubCell, rimCell, spokePatternCell, nil],
                     [NSArray arrayWithObjects:leftLengthCell, rightLengthCell, nil],
                     [NSArray arrayWithObjects:sendEmailCell, nil],
                     nil] retain];
        
        NSArray *patternValues = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], nil];
        NSArray *patternLabels = [NSArray arrayWithObjects: @"radial", @"1 cross", @"2 cross", @"3 cross", @"4 cross", nil];
        patternPickerOptions = [[NSDictionary dictionaryWithObjects:patternLabels forKeys:patternValues] retain];
        
        PatternPickerDelegate *pickerDeleagate = [[[PatternPickerDelegate alloc] init] autorelease];
        pickerDeleagate.editWheelDelegate = self;
        
        spokePatternPicker = [[[CheckmarkPickerController alloc] initWithStyle:UITableViewStyleGrouped] retain];
        spokePatternPicker.title = @"Spoke Pattern";
        spokePatternPicker.delegate = pickerDeleagate;
        spokePatternPicker.options = patternValues;
        spokePatternPicker.selectedIndex = 3;
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
    
    if ([self.tableView numberOfSections] > [self numberOfSectionsInTableView:self.tableView]) {
        NSIndexSet *indices = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self numberOfSectionsInTableView:self.tableView],
                                                                                  [self.tableView numberOfSections] - [self numberOfSectionsInTableView:self.tableView])];
        [self.tableView deleteSections: indices
                      withRowAnimation: UITableViewRowAnimationFade];
    }
    
}

- (void) disableEdit {
    self.editing = NO;
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
    
    if ([self.tableView numberOfSections] < [self numberOfSectionsInTableView:self.tableView]) {
        NSIndexSet *indices = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self.tableView numberOfSections],
                                                                                [self numberOfSectionsInTableView:self.tableView] - [self.tableView numberOfSections])];
        [self.tableView insertSections: indices
                      withRowAnimation: UITableViewRowAnimationFade];
    }
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
        [FlurryAPI logEvent:@"Create Wheel"];
        [delegate afterCreateWheel:self.wheel];
        [self dismissModalViewControllerAnimated:YES];
    }
    else {
        [wheel update];
        [FlurryAPI logEvent:@"Update Wheel"];
        [delegate afterUpdateWheel:wheel];
        [self disableEdit];
    }
}

#pragma mark EditWheelDelegate methods

-(void)setHub:(Hub *)hub {
    self.wheel.hub = hub;
    [FlurryAPI logEvent:@"Choose Hub" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      hub.brand,  @"brand", 
                                                      hub.description, @"description",
                                                      nil]];
    [self.navigationController popToViewController:self animated:YES];
}

-(void)setRim:(Rim *)rim {
    self.wheel.rim = rim;
    [FlurryAPI logEvent:@"Choose Rim" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      rim.brand,  @"brand", 
                                                      rim.description, @"description",
                                                      nil]];
    [self.navigationController popToViewController:self animated:YES];
}

-(void)setSpokePattern:(NSNumber *)cross {
    wheel.spokePattern = cross;
    [FlurryAPI logEvent:@"Choose Spoke Pattern" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      wheel.spokePatternDescription,  @"pattern",
                                                      nil]];
}

- (void) updateView {
    rimCell.detailTextLabel.text = wheel.rim ? [NSString stringWithFormat:@"%@ %@",wheel.rim.brand, wheel.rim.description] : @"";
    hubCell.detailTextLabel.text = wheel.hub ? [NSString stringWithFormat:@"%@ %@",wheel.hub.brand, wheel.hub.description] : @"";
    spokePatternCell.detailTextLabel.text = wheel.spokePattern ? wheel.spokePatternDescription : @"";
    
    leftLengthCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ mm", [wheel leftSpokeLength]];
    rightLengthCell.detailTextLabel.text = [NSString stringWithFormat:@"%@ mm", [wheel rightSpokeLength]];
    
    [self.tableView reloadData];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (editing || !wheel.isValid) {
        return sections.count - 2;
    }
    return sections.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Build Specs";
        case 1:
            return @"Spoke Lengths";
        default: 
            return nil;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return SECTION_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[sections objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (cell == hubCell) {
        hubDetailController.editWheelDelegate = self;
        if (editing) {
            hubDetailController.canChoosePart = YES;
            hubBrandsController.holeCount = wheel.rim.holeCount;
            hubBrandsController.brands = [Hub selectBrandNamesForHoleCount:wheel.rim.holeCount];
            [self.navigationController pushViewController:hubBrandsController animated:YES];
        }
        else if (wheel.hub) {
            hubDetailController.hub = wheel.hub;
            hubDetailController.canChoosePart = NO;
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
        spokePatternPicker.selectedIndex = self.wheel.spokePattern ? [self.wheel.spokePattern intValue] : -1;
        [self.navigationController pushViewController:spokePatternPicker animated:YES];
    }
    else if (cell == sendEmailCell){
        WheelEmail *email = [WheelEmail emailForWheel:wheel];
        NSLog(@"Send email %@", [email createMailToUrl]);
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: [email createMailToUrl]]];
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

