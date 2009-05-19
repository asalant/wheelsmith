#import "RimBrandsController.h"
#import "RimListController.h"
#import "Rim.h"

@implementation RimBrandsController

@synthesize editController, rimsController, wheel;

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                            target:self 
                                                                                            action:@selector(addPart)] autorelease];
}


#pragma mark RimEditDelegate methods

-(void)rimSaved:(Rim *)rim created:(BOOL)created {
    self.brands = [Rim selectBrandNamesForHoleCount:self.holeCount];
    [self.tableView reloadData];
}

#pragma mark UITableViewController methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *brand = [brands objectAtIndex:indexPath.row];
    rimsController.title = brand;
    rimsController.brand = brand;
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


-(void)addPart {
    editController.rim = [[[Rim alloc] init] autorelease];
    [self.navigationController pushViewController:editController animated:YES];
    [editController.brandTextField becomeFirstResponder];
}

- (void) dealloc {
    [editController release];
    [rimsController release];
    [wheel release];
    [super dealloc];
}

@end

