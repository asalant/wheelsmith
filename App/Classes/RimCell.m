#import "RimCell.h"

@implementation RimCell

@synthesize descriptionLabel, sizeLabel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

- (Rim *) rim {
    return nil;
}

- (void) setRim:(Rim *)rim {
    descriptionLabel.text = rim.description;
    sizeLabel.text = [rim.size description];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	[descriptionLabel release];
	[sizeLabel release];
    [super dealloc];
}


@end
