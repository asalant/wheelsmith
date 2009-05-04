#import "RimListController.h"
#import "RimDetailController.h"
#import "RimCell.h"
#import "Rim.h"
#import "TableCellFactory.h"

@implementation RimListController

@synthesize rims, wheel, rimDetailController;

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
    return rims.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Rim";
	RimCell *cell = (RimCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (RimCell *)[TableCellFactory createTableCellForClass:[RimCell class]
                                                              andNib:@"RimCell"
                                                      withIdentifier:CellIdentifier];
    }
    
    cell.rim = [rims objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Rim *rim = [rims objectAtIndex:indexPath.row];
    rimDetailController.title = rim.description;
    rimDetailController.rim = rim;
    [rimDetailController viewDidLoad];
    
    [self.navigationController pushViewController:rimDetailController animated:YES];
}

- (void)dealloc {
    [rims release];
    [wheel release];
    [rimDetailController release];
    [super dealloc];
}


@end

