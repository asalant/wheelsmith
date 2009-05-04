#import "HubListController.h"
#import "HubCell.h"
#import "Hub.h"
#import "TableCellFactory.h"

@implementation HubListController

@synthesize hubs, wheel, hubDetailController;

/*
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
 // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 }
 */

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return hubs.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Hub";
	HubCell *cell = (HubCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (HubCell *)[TableCellFactory createTableCellForClass:[HubCell class]
                                                             andNib:@"HubCell"
                                                     withIdentifier:CellIdentifier];
    }
    
    cell.hub = [hubs objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Hub *hub = [hubs objectAtIndex:indexPath.row];
    hubDetailController.title = hub.description;
    hubDetailController.hub = hub;
    
    [self.navigationController pushViewController:hubDetailController animated:YES];
}


- (void)dealloc {
    [hubs release];
    [wheel release];
    [hubDetailController release];
    [super dealloc];
}


@end

