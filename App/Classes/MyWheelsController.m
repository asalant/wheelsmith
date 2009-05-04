#import "MyWheelsController.h"
#import "Wheel.h"
#import "TableCellFactory.h"
#import "LabeledValueCell.h"

@implementation MyWheelsController

@synthesize wheels, wheelDetailController, newWheelController;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"My Wheels";
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                                           target:self 
                                                                                           action:@selector(addButtonWasPressed)] autorelease];
}

#pragma mark Add Wheel

-(void)addButtonWasPressed {
    wheelDetailController.wheel = [[[Wheel alloc] init] autorelease];
    [self presentModalViewController:newWheelController animated:YES];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return wheels.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"LabeledValue";
    
    LabeledValueCell *cell = (LabeledValueCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (LabeledValueCell *)[TableCellFactory createTableCellForClass:[LabeledValueCell class]
                                                                      andNib:@"LabeledValueCell" 
                                                              withIdentifier:CellIdentifier];
    }
    
    Wheel *wheel = [wheels objectAtIndex:indexPath.row];
    [cell setLabel:[NSString stringWithFormat:@"%@ / %@", wheel.hub.brand, wheel.rim.brand]
         withValue:wheel.spokePatternDescription];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    wheelDetailController.wheel = [wheels objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:wheelDetailController animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


- (void)dealloc {
    [wheels release];
    [wheelDetailController release];
    [super dealloc];
}


@end

