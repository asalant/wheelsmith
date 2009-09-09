#import "HubListController.h"
#import "HubCell.h"
#import "Hub.h"
#import "TableCellFactory.h"

@implementation HubListController

@synthesize hubs, brand, hubDetailController, editController;

-(void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
//                                                                                            target:self 
//                                                                                            action:@selector(addPart)] autorelease];
}

-(void)addPart {
    hubDetailController.hub = [[[Hub alloc] init] autorelease];
    hubDetailController.hub.brand = brand;
    [self.navigationController pushViewController:hubDetailController animated:YES];
}

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
    hubDetailController.hub = [hubs objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:hubDetailController animated:YES];
}


- (void)dealloc {
    [hubs release];
    [hubDetailController release];
    [super dealloc];
}


@end

