#import "RimBrandListController.h"
#import "RimListController.h"
#import "Rim.h"

@implementation RimBrandListController

@synthesize rimListController;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *brand = [companies objectAtIndex:indexPath.row];
    rimListController.title = brand;
    rimListController.rims = [Rim findByCriteria:[NSString stringWithFormat:@"brand = '%@'", brand]  orderBy:@"description"];
    [rimListController.tableView reloadData];
    
    [self.navigationController pushViewController:rimListController animated:YES];
}

- (void) dealloc {
    [rimListController release];
    [super dealloc];
}

@end

