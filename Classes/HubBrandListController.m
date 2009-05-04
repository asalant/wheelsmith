#import "HubBrandListController.h"
#import "HubListController.h"
#import "Hub.h"

@implementation HubBrandListController

@synthesize hubListController;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *brand = [companies objectAtIndex:indexPath.row];
    hubListController.title = brand;
    hubListController.hubs = [Hub findByCriteria:[NSString stringWithFormat:@"brand = '%@'", brand]  orderBy:@"description"];
    [hubListController.tableView reloadData];
    
    [self.navigationController pushViewController:hubListController animated:YES];
}

- (void) dealloc {
    [hubListController release];
    [super dealloc];
}

@end

