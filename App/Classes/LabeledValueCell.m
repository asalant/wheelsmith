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

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)dealloc {
	[labelLabel release];
	[valueLabel release];
    [super dealloc];
}


@end
