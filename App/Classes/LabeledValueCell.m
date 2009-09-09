#import "LabeledValueCell.h"
#import "TableCellFactory.h"

@implementation LabeledValueCell

@synthesize textLabel, detailTextLabel;

+ (LabeledValueCell *) createCell {
    return (LabeledValueCell *)[TableCellFactory createTableCellForClass:[self class]
                                                                andNib:@"ValueCell" 
                                                        withIdentifier:@"Value"];
}

+ (LabeledValueCell *) createCellWithLabel:(NSString *)label {
    LabeledValueCell *cell = (LabeledValueCell *)[TableCellFactory createTableCellForClass:[self class]
                                                                  andNib:@"LabeledValueCell" 
                                                          withIdentifier:@"LabeledValue"];
    cell.textLabel.text = label;
    return cell;
}

- (void) setValue:(NSString *)value {
    detailTextLabel.text = value;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    if (editing) {
        detailTextLabel.hidden = YES;
    }
    else {
        detailTextLabel.hidden = NO;
    }
    [super setEditing:editing animated:animated];
}

- (void)dealloc {
	[textLabel release];
	[detailTextLabel release];
    [super dealloc];
}


@end
