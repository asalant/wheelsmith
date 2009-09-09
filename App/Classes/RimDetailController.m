#import "RimDetailController.h"
#import "StringUtil.h"
#import "FlurryAPI.h"

@implementation RimDetailController

@synthesize rim;
@synthesize editWheelDelegate, canChoosePart;

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        brandCell = [LabeledValueCell createCell];
        descriptionCell = [LabeledValueCell createCell];
        sizeCell = [LabeledValueCell createCell];
        holeCountCell = [LabeledValueCell createCell];
        
        erdCell = [LabeledValueCell createCellWithLabel:@"ERD"];
        offsetCell = [LabeledValueCell createCellWithLabel:@"Offset"];
        
        sections = [[NSArray arrayWithObjects:
                     [NSArray arrayWithObjects:brandCell, descriptionCell, holeCountCell, nil],
                     [NSArray arrayWithObjects:erdCell, nil],
                     [NSArray arrayWithObjects:offsetCell, nil],
                     nil] retain];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (canChoosePart)
    {
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                                target:self 
                                                                                                action:@selector(chooseRim)] autorelease];
    }
    else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    brandCell.detailTextLabel.text = rim.brand;
    descriptionCell.detailTextLabel.text = rim.description;
    //sizeCell.detailTextLabel.text = rim.sizeDescription;
    holeCountCell.detailTextLabel.text = [NSString stringWithFormat:@"%d holes, %@", [rim.holeCount intValue], rim.sizeDescription];
    erdCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f mm", [rim.erd floatValue]];
    offsetCell.detailTextLabel.text = [NSString stringWithFormat:@"%.1f mm", [rim.offset floatValue]];
    
}

-(IBAction)chooseRim {
    [self.editWheelDelegate setRim:rim];
}

-(IBAction)deleteRim {
    [rim delete];
    [FlurryAPI logEvent:@"Delete Rim"];
    [self.editWheelDelegate setRim:nil];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sections.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 1:
            return @"Effective Rim Diameter";
            break;
        case 2:
            return @"Spoke Hole Offset";
            break;
        default:
            return nil;
    }
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
    [rim release];
    [super dealloc];
}


@end

