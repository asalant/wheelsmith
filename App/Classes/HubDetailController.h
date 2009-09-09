#import <UIKit/UIKit.h>
#import "Hub.h"
#import "EditWheelDelegate.h"
#import "LabeledValueCell.h"
#import "ButtonCell.h"

@interface HubDetailController : UITableViewController {
    Hub *hub;
    LabeledValueCell *brandCell;
    LabeledValueCell *descriptionCell;
    LabeledValueCell *rearCell;
    LabeledValueCell *holeCountCell;
    LabeledValueCell *leftFlangeDiameterCell;
    LabeledValueCell *leftFlangeToCenterCell;
    LabeledValueCell *rightFlangeDiameterCell;
    LabeledValueCell *rightFlangeToCenterCell;
    NSArray *sections;
    id<EditWheelDelegate> editWheelDelegate;
    BOOL canChoosePart;
}

@property(nonatomic, retain) Hub *hub;
@property(nonatomic, retain) id<EditWheelDelegate> editWheelDelegate;
@property(nonatomic, assign) BOOL canChoosePart;

-(IBAction) chooseHub;

@end
