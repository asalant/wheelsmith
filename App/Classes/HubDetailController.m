#import "HubDetailController.h"
#import "StringUtil.h"

@implementation HubDetailController

@synthesize hub;
@synthesize brandLabel, descriptionLabel;
@synthesize rearLabel, holeCountLabel, leftFlangeDiameter, leftFlangeToCenter, rightFlangeDiameter, rightFlangeToCenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    brandLabel.text = hub.brand;
    descriptionLabel.text = hub.description;
    rearLabel.text = hub.rear ? @"Rear" : @"Front";
    holeCountLabel.text = [NSString stringWithFormat:@"%d holes", [hub.holeCount intValue]];
    leftFlangeDiameter.text = [StringUtil formatFloat:hub.leftFlangeDiameter];
    leftFlangeToCenter.text = [StringUtil formatFloat:hub.leftFlangeToCenter];
    rightFlangeDiameter.text = [StringUtil formatFloat:hub.rightFlangeDiameter];
    rightFlangeToCenter.text = [StringUtil formatFloat:hub.rightFlangeToCenter];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
    [hub release];
    [super dealloc];
}


@end

