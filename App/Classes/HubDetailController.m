#import "HubDetailController.h"
#import "StringUtil.h"

@implementation HubDetailController

@synthesize hub;
@synthesize brandLabel, descriptionLabel;
@synthesize rearLabel, holeCountLabel, leftFlangeDiameter, leftFlangeToCenter, rightFlangeDiameter, rightFlangeToCenter;
@synthesize editWheelDelegate;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    brandLabel.text = hub.brand;
    descriptionLabel.text = hub.description;
    rearLabel.text = [hub.rear boolValue] ? @"Rear" : @"Front";
    holeCountLabel.text = [NSString stringWithFormat:@"%d holes", [hub.holeCount intValue]];
    leftFlangeDiameter.text = [StringUtil formatFloat:hub.leftFlangeDiameter];
    leftFlangeToCenter.text = [StringUtil formatFloat:hub.leftFlangeToCenter];
    rightFlangeDiameter.text = [StringUtil formatFloat:hub.rightFlangeDiameter];
    rightFlangeToCenter.text = [StringUtil formatFloat:hub.rightFlangeToCenter];
}

-(IBAction) chooseHub {
    [self.editWheelDelegate setHub:hub];
}

- (void)dealloc {
    [hub release];
    [super dealloc];
}


@end

