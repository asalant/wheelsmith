#import "HubCell.h"

@implementation HubCell

@synthesize descriptionLabel, rearLabel, holeCountLabel;

- (Hub *) hub {
    return nil;
}

- (void) setHub:(Hub *)hub {
    descriptionLabel.text = hub.description;
    rearLabel.text = hub.rearDescription;
    holeCountLabel.text = hub.holeCount ? [NSString stringWithFormat:@"%@h", hub.holeCount] : nil;
}

- (void)dealloc {
	[descriptionLabel release];
	[rearLabel release];
    [super dealloc];
}


@end
