#import "WheelCell.h"

@implementation WheelCell

@synthesize partsLabel, detailLabel, wheelImage;

-(Wheel *)wheel {
    return nil;
}

-(void)setWheel:(Wheel *)wheel {
    [wheel retain];
    partsLabel.text = [NSString stringWithFormat:@"%@ / %@", wheel.hub ? wheel.hub.brand : @"?", wheel.rim ? wheel.rim.brand : @"?"];

    NSMutableArray *details = [NSMutableArray array];
    if (wheel.spokePattern)
        [details addObject:wheel.spokePatternDescription];
    if (wheel.rim && wheel.rim.holeCount)
        [details addObject:[NSString stringWithFormat:@"%@h", wheel.rim.holeCount]];
    else if (wheel.hub && wheel.hub.holeCount)
        [details addObject:[NSString stringWithFormat:@"%@h", wheel.hub.holeCount]];
    if (wheel.rim && wheel.rim.size) 
        [details addObject:wheel.rim.sizeDescription];
    if (wheel.hub)
        [details addObject:wheel.hub.rearDescription];
    detailLabel.text = [details componentsJoinedByString:@", "];
    
    //float scale = [wheel.rim.size floatValue] / 630.0;
//    CGSize size = CGSizeMake(wheelImage.frame.size.width * scale, wheelImage.frame.size.height * scale);
//    wheelImage.frame = CGRectMake(wheelImage.frame.origin.x, wheelImage.frame.origin.x, size.width, size.height);
}

- (void)dealloc {
    [partsLabel release];
    [detailLabel release];
    [wheelImage release];
    [super dealloc];
}


@end
