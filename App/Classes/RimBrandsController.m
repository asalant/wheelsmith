#import "RimBrandsController.h"
#import "RimListController.h"
#import "Rim.h"

@implementation RimBrandsController

@synthesize editController, rimsController, wheel;

-(void)addPart {
    editController.rim = [[[Rim alloc] init] autorelease];
    editController.delegate = self;
    [self.navigationController pushViewController:editController animated:YES];
    [editController.brandTextField becomeFirstResponder];
}

#pragma mark UITableViewController methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *brand = [brands objectAtIndex:indexPath.row];
    rimsController.title = brand;
    rimsController.brand = brand;
    rimsController.rims = [Rim findByBrand:brand andHoleCount:holeCount];
    [rimsController.tableView reloadData];
    
    [self.navigationController pushViewController:rimsController animated:YES];
}

- (void) dealloc {
    [editController release];
    [rimsController release];
    [wheel release];
    [super dealloc];
}

@end

