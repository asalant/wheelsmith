#import "CheckmarkPickerController.h"

@implementation CheckmarkPickerController

@synthesize selectedIndex, options, delegate;

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                            target:self 
                                                                                            action:@selector(commitSelection)] autorelease];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(id)selectedOption {
    if (!selectedIndex)
        return nil;
    return [options objectAtIndex:[selectedIndex intValue]];
}

-(void)setSelectedOption:(id)option {
    int index = [options indexOfObject:option];
    if (index == NSNotFound) {
        self.selectedIndex = nil;
    }
    else {
        self.selectedIndex = [NSNumber numberWithInt:index];
    }
}

-(void)commitSelection {
    [delegate optionSelected:self.selectedOption];
    [self.navigationController popViewControllerAnimated:YES];
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
    
    static NSString *CellIdentifier = @"OptionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    cell.text = [delegate labelForOption:[options objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (selectedIndex && indexPath.row == [selectedIndex intValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = [NSNumber numberWithInt:indexPath.row];
    [self.tableView reloadData];
}

- (void)dealloc {
    [options release];
    [selectedIndex release];
    [super dealloc];
}


@end

