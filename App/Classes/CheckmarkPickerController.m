#import "CheckmarkPickerController.h"

@implementation CheckmarkPickerController

@synthesize selectedIndex, options, delegate;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(id)selectedOption {
    if (selectedIndex < 0 || selectedIndex > options.count - 1) {
        return nil;
    }
    return [options objectAtIndex:selectedIndex];
}

-(void)setSelectedIndex:(int)index {
    selectedIndex = index;
    [delegate optionSelected:self.selectedOption];
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        //cell.textLabel.font = [UIFont systemFontOfSize:17];
    }
    
    // Set up the cell...
    cell.textLabel.text = [delegate labelForOption:[options objectAtIndex:indexPath.row]];
    if (indexPath.row == selectedIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1];
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor blackColor];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableSet *changedIndices = [NSMutableSet setWithObject:indexPath];
    if (self.selectedOption) {
        [changedIndices addObject:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
    }
    self.selectedIndex = indexPath.row;

    [tableView reloadRowsAtIndexPaths:[changedIndices allObjects]  withRowAnimation:UITableViewRowAnimationNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc {
    [options release];
    [super dealloc];
}


@end

