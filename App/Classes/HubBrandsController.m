#import "HubBrandsController.h"
#import "HubListController.h"
#import "Hub.h"

@implementation HubBrandsController

@synthesize hubsController, wheel, editController;

-(void)addPart {
    editController.hub = [[[Hub alloc] init] autorelease];
    [self.navigationController pushViewController:editController animated:YES];
    [editController.brandTextField becomeFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *brand = [brands objectAtIndex:indexPath.row];
    hubsController.title = brand;
    hubsController.brand = brand;
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

