#import "HubCell.h"

@implementation HubCell

@synthesize descriptionLabel, rearLabel;

- (Hub *) hub {
    return nil;
}

- (void) setHub:(Hub *)hub {
    descriptionLabel.text = hub.description;
    rearLabel.text = [hub.rear boolValue] ? @"Rear" : @"Front";
}

- (void)dealloc {
	[descriptionLabel release];
	[rearLabel release];
    [super dealloc];
}


@end
