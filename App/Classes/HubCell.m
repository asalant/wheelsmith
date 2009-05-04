#import "HubCell.h"

@implementation HubCell

@synthesize descriptionLabel, rearLabel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

- (Hub *) hub {
    return nil;
}

- (void) setHub:(Hub *)hub {
    descriptionLabel.text = hub.description;
    rearLabel.text = hub.rear ? @"Rear" : @"Front";
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)dealloc {
	[descriptionLabel release];
	[rearLabel release];
    [super dealloc];
}


@end
