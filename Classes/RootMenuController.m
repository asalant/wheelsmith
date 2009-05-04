#import "RootMenuController.h"
#import "Rim.h"
#import "Hub.h"
#import "TableCellFactory.h"

@implementation RootMenuController

@synthesize myWheelsCell, rimsCell, hubsCell;
@synthesize myWheelsController, rimBrandListController, hubBrandListController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Menu";
    
    self.myWheelsCell = (LabeledValueCell *)[TableCellFactory createTableCellForClass:[LabeledValueCell class] 
                                                                           andNib:@"LabeledValueCell" 
                                                                   withIdentifier:@"LabeledValue"];
    [self.myWheelsCell setLabel: @"My Wheels" 
                      withValue:[NSString stringWithFormat:@"%d", myWheelsController.wheels.count]];
    
    self.rimsCell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:nil] autorelease];
    self.rimsCell.text = @"Rims";
    self.hubsCell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:nil] autorelease];
    self.hubsCell.text = @"Hubs";
    
    sections = [[NSArray arrayWithObjects:
                 [NSArray arrayWithObjects:self.myWheelsCell, nil],
                 [NSArray arrayWithObjects:self.hubsCell, self.rimsCell, nil],
                 nil] retain];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (cell == myWheelsCell) {
        [self.navigationController pushViewController:myWheelsController animated:YES];
    }
    else if (cell == rimsCell) {
        rimBrandListController.companies = [Rim selectBrandNames];
        [self.navigationController pushViewController:rimBrandListController animated:YES];
    }
    else if (cell == hubsCell) {
        hubBrandListController.companies = [Hub selectBrandNames];
        [self.navigationController pushViewController:hubBrandListController animated:YES];
    }
}

- (void)dealloc {
    [myWheelsController release];
    [rimBrandListController release];
    [hubBrandListController release];
    [sections release];
    [super dealloc];
}


@end

