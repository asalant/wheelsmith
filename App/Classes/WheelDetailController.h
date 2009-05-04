#import <UIKit/UIKit.h>
#import "Wheel.h"
#import "HubDetailController.h"
#import "RimDetailController.h"
#import "HubBrandsController.h"
#import "RimBrandsController.h"
#import "LabeledValueCell.h"
#import "PickerController.h"
#import "EditWheelDelegate.h"

@interface WheelDetailController : UITableViewController <EditWheelDelegate> {
    Wheel *wheel;
    LabeledValueCell *rimCell;
    LabeledValueCell *hubCell;
    LabeledValueCell *spokeCountCell;
    LabeledValueCell *spokePatternCell;
    LabeledValueCell *leftLengthCell;
    LabeledValueCell *rightLengthCell;
    HubDetailController *hubDetailController;
    RimDetailController *rimDetailController;
    HubBrandsController *hubBrandsController;
    RimBrandsController *rimBrandsController;
    PickerController *spokePatternPicker;
    NSArray *sections;

}

@property(nonatomic, retain) Wheel *wheel;
@property(nonatomic, retain) HubDetailController *hubDetailController;
@property(nonatomic, retain) RimDetailController *rimDetailController;
@property(nonatomic, retain) HubBrandsController *hubBrandsController;
@property(nonatomic, retain) RimBrandsController *rimBrandsController;

- (void) updateView;

@end
