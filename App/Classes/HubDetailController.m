#import "HubDetailController.h"
#import "StringUtil.h"
#import "FlurryAPI.h"

@implementation HubDetailController

@synthesize hub;
@synthesize editWheelDelegate, canChoosePart;

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        brandCell = [LabeledValueCell createCell];
        descriptionCell = [LabeledValueCell createCell];
        rearCell = [LabeledValueCell createCell];
        holeCountCell = [LabeledValueCell createCell];
        
        leftFlangeDiameterCell = [LabeledValueCell createCellWithLabel:@"Diameter"];
        leftFlangeToCenterCell = [LabeledValueCell createCellWithLabel:@"To Center"];
        
        rightFlangeDiameterCell = [LabeledValueCell createCellWithLabel:@"Diameter"];
        rightFlangeToCenterCell = [LabeledValueCell createCellWithLabel:@"To Center"];
        
        sections = [[NSArray arrayWithObjects:
                     [NSArray arrayWithObjects:brandCell, descriptionCell, holeCountCell, nil],
                     [NSArray arrayWithObjects:leftFlangeDiameterCell, leftFlangeToCenterCell, nil],
                     [NSArray arrayWithObjects:rightFlangeDiameterCell, rightFlangeToCenterCell, nil], 
                     nil] retain];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (canChoosePart) {
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                                target:self 
                                                                                                action:@selector(chooseHub)] autorelease];
    }
    else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    brandCell.detailTextLabel.text = hub.brand;
    descriptionCell.detailTextLabel.text = hub.description;
//    rearCell.detailTextLabel.text = hub.rearDescription;
    holeCountCell.detailTextLabel.text = [NSString stringWithFormat:@"%d holes, %@", [hub.holeCount intValue], hub.rearDescription];
    
    leftFlangeDiameterCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f mm", [hub.leftFlangeDiameter floatValue]];
    leftFlangeToCenterCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f mm", [hub.leftFlangeToCenter floatValue]];
    
    rightFlangeDiameterCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f mm", [hub.rightFlangeDiameter floatValue]];
    rightFlangeToCenterCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f mm", [hub.rightFlangeToCenter floatValue]];
}

-(IBAction) chooseHub {
    [self.editWheelDelegate setHub:hub];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sections.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return @"Left Flange";
        case 2:
            return @"Right Flange";
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)dealloc {
    [hub release];
    [super dealloc];
}


@end

