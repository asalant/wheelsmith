#import "MyWheelsController.h"
#import "Wheel.h"
#import "TableCellFactory.h"
#import "WheelCell.h"
#import "FlurryAPI.h"

@implementation MyWheelsController

@synthesize wheels, wheelDetailController, newWheelController;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem; 
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                                           target:self 
                                                                                           action:@selector(addWheel)] autorelease];
}

#pragma mark WheelDetailDelegate methods

-(void) afterCreateWheel:(Wheel *)theWheel {
    [self.wheels insertObject:theWheel atIndex:0];
    //http://bill.dudney.net/roller/objc/entry/quick_table_view_weirdness
    if (self.wheels.count == 1) {
        [self.tableView reloadData];
    }
    else {
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    wheelDetailController.wheel = theWheel;
	[self.navigationController pushViewController:wheelDetailController animated:NO];
}

-(void) afterUpdateWheel:(Wheel *)theWheel {
    [self.tableView reloadData];
}

#pragma mark Add Wheel

-(void)addWheel {
    ((WheelDetailController *)newWheelController.topViewController).wheel = [[[Wheel alloc] init] autorelease];
    ((WheelDetailController *)newWheelController.topViewController).editing = YES;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Wheel";
    
    WheelCell *cell = (WheelCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (WheelCell *)[TableCellFactory createTableCellForClass:[WheelCell class]
                                                                      andNib:@"WheelCell" 
                                                              withIdentifier:CellIdentifier];
    }
    
    cell.wheel = [wheels objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    wheelDetailController.wheel = [wheels objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:wheelDetailController animated:YES];

}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Wheel *wheel = [self.wheels objectAtIndex:indexPath.row];
        [wheel delete];
        [FlurryAPI logEvent:@"Delete Wheel"];
        [self.wheels removeObject:wheel];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)dealloc {
    [wheels release];
    [wheelDetailController release];
    [super dealloc];
}


@end

