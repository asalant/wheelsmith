#import "RimListController.h"
#import "RimDetailController.h"
#import "RimCell.h"
#import "Rim.h"
#import "TableCellFactory.h"

@implementation RimListController

@synthesize rims, brand, rimDetailController, editController;

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                            target:self 
                                                                                            action:@selector(addPart)] autorelease];
}

-(void)addPart {
    editController.rim = [[[Rim alloc] init] autorelease];
    editController.rim.brand = brand;
    [self.navigationController pushViewController:editController animated:YES];
    [editController.descriptionTextField becomeFirstResponder];
}

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
    rimDetailController.rim = [rims objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:rimDetailController animated:YES];
}

- (void)dealloc {
    [rims release];
    [rimDetailController release];
    [editController release];
    [super dealloc];
}


@end

