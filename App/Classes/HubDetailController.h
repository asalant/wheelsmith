#import <UIKit/UIKit.h>
#import "Hub.h"

@interface HubDetailController : UIViewController {
    Hub *hub;
    IBOutlet UILabel *brandLabel;
    IBOutlet UILabel *descriptionLabel;
    IBOutlet UILabel *rearLabel;
    IBOutlet UILabel *holeCountLabel;
    IBOutlet UILabel *leftFlangeDiameter;
    IBOutlet UILabel *leftFlangeToCenter;
    IBOutlet UILabel *rightFlangeDiameter;
    IBOutlet UILabel *rightFlangeToCenter;
}

@property(nonatomic, retain) Hub *hub;
@property(nonatomic, retain) UILabel *brandLabel;
@property(nonatomic, retain) UILabel *descriptionLabel;
@property(nonatomic, retain) UILabel *rearLabel;
@property(nonatomic, retain) UILabel *holeCountLabel;
@property(nonatomic, retain) UILabel *leftFlangeDiameter;
@property(nonatomic, retain) UILabel *leftFlangeToCenter;
@property(nonatomic, retain) UILabel *rightFlangeDiameter;
@property(nonatomic, retain) UILabel *rightFlangeToCenter;

-(IBAction) chooseHub;

@end
