#import "HubBrandsController.h"
#import "HubListController.h"
#import "Hub.h"

@implementation HubBrandsController

@synthesize hubsController, wheel;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *brand = [brands objectAtIndex:indexPath.row];
    hubsController.title = brand;
    hubsController.hubs = [Hub findByBrand:brand andHoleCount:holeCount];
    [hubsController.tableView reloadData];
    
    [self.navigationController pushViewController:hubsController animated:YES];
}

- (void) dealloc {
    [hubsController release];
    [wheel release];
    [super dealloc];
}

@end

