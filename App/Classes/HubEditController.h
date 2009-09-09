#import <UIKit/UIKit.h>
#import "Hub.h"
#import "HubDetailController.h"

@interface HubEditController : UIViewController {
    Hub *hub;
    IBOutlet UITextField *brandTextField;
    IBOutlet UITextField *descriptionTextField;
    IBOutlet UITextField *holeCountTextField;
    IBOutlet UISwitch    *rearSwitch;
    IBOutlet UITextField *leftFlangeDiameterTextField;
    IBOutlet UITextField *leftFlangeToCenterTextField;
    IBOutlet UITextField *rightFlangeDiameterTextField;
    IBOutlet UITextField *rightFlangeToCenterTextField;
    id currentInput;
    NSArray *textFields;
    HubDetailController *detailController;
}

@property(nonatomic, retain) Hub *hub;
@property(nonatomic, retain) UITextField *brandTextField;
@property(nonatomic, retain) UITextField *descriptionTextField;
@property(nonatomic, retain) UITextField *holeCountTextField;
@property(nonatomic, retain) UISwitch    *rearSwitch;
@property(nonatomic, retain) UITextField *leftFlangeDiameterTextField;
@property(nonatomic, retain) UITextField *leftFlangeToCenterTextField;
@property(nonatomic, retain) UITextField *rightFlangeDiameterTextField;
@property(nonatomic, retain) UITextField *rightFlangeToCenterTextField;
@property(nonatomic, retain) HubDetailController *detailController;

-(IBAction)saveHub;

@end
