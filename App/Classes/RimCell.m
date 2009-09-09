#import "RimCell.h"

@implementation RimCell

@synthesize descriptionLabel, sizeLabel, holeCountLabel;

- (Rim *) rim {
    return nil;
}

- (void) setRim:(Rim *)rim {
    descriptionLabel.text = rim.description;
    sizeLabel.text = rim.sizeDescription;
    holeCountLabel.text = rim.holeCount ? [NSString stringWithFormat:@"%@h", rim.holeCount] : nil;
}


- (void)dealloc {
	[descriptionLabel release];
	[sizeLabel release];
	[holeCountLabel release];
    [super dealloc];
}


@end
