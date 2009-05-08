#import "HubBrandsController.h"
#import "HubListController.h"
#import "Hub.h"

@implementation HubBrandsController

@synthesize hubsController, wheel;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *brand = [brands objectAtIndex:indexPath.row];
    hubsController.title = brand;
    if (holeCount) {
        hubsController.hubs = [Hub findByCriteria:[NSString stringWithFormat:@"brand = '%@' AND hole_count = %@", brand, holeCount] 
                                          orderBy:@"description"];
    }
    else {
        hubsController.hubs = [Hub findByCriteria:[NSString stringWithFormat:@"brand = '%@'", brand]  
                                          orderBy:@"description"];
    }
    [hubsController.tableView reloadData];
    
    [self.navigationController pushViewController:hubsController animated:YES];
}

- (void) dealloc {
    [hubsController release];
    [wheel release];
    [super dealloc];
}

@end

