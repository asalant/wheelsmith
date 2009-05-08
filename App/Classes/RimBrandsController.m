#import "RimBrandsController.h"
#import "RimListController.h"
#import "Rim.h"

@implementation RimBrandsController

@synthesize rimsController, wheel;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *brand = [brands objectAtIndex:indexPath.row];
    rimsController.title = brand;
    if (holeCount) {
        rimsController.rims = [Rim findByCriteria:[NSString stringWithFormat:@"brand = '%@' AND hole_count = %@", brand, holeCount]  
                                          orderBy:@"description"];
    }
    else {
        rimsController.rims = [Rim findByCriteria:[NSString stringWithFormat:@"brand = '%@'", brand]  
                                          orderBy:@"description"];
    }
    [rimsController.tableView reloadData];
    
    [self.navigationController pushViewController:rimsController animated:YES];
}

- (void) dealloc {
    [rimsController release];
    [wheel release];
    [super dealloc];
}

@end

