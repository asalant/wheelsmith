#import "LabeledValueCell.h"
#import "TableCellFactory.h"

@implementation LabeledValueCell

@synthesize labelLabel, valueLabel;

+ (LabeledValueCell *) createCell {
    return (LabeledValueCell *)[TableCellFactory createTableCellForClass:[self class]
                                                                     andNib:@"LabeledValueCell" 
                                                             withIdentifier:@"LabeledValue"];
}

+ (LabeledValueCell *) createCellWithLabel:(NSString *)label withValue:(NSString *)value {
    LabeledValueCell *cell = [self createCell];
    [cell setLabel:label withValue:value];
    return cell;
}

- (void) setLabel:(NSString *)label withValue:(NSString *)value {
    labelLabel.text = label;
    valueLabel.text = value;
}

- (void) setValue:(NSString *)value {
    valueLabel.text = value;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    if (editing) {
        valueLabel.hidden = YES;
    }
    else {
        valueLabel.hidden = NO;
    }
    [super setEditing:editing animated:animated];
}

- (void)dealloc {
	[labelLabel release];
	[valueLabel release];
    [super dealloc];
}


@end
