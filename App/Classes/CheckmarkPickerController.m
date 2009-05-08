#import "CheckmarkPickerController.h"

@implementation CheckmarkPickerController

@synthesize selectedIndex, options, delegate;

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                            target:self 
                                                                                            action:@selector(commitSelection)] autorelease];
}

-(id)selectedOption {
    if (!selectedIndex)
        return nil;
    return [options objectAtIndex:[selectedIndex intValue]];
}

-(void)commitSelection {
    [self dismissModalViewControllerAnimated:YES];
    [delegate optionSelected:[self selectedOption]];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return options.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"OptionsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    cell.text = [delegate labelForOption:[options objectAtIndex:indexPath.row]];
    if (selectedIndex && indexPath.row == [selectedIndex intValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedIndex = [NSNumber numberWithInt:indexPath.row];
    [self.tableView reloadData];
}

- (void)dealloc {
    [options release];
    [selectedIndex release];
    [super dealloc];
}


@end

