#import <UIKit/UIKit.h>
#import "Wheel.h"
#import "HubDetailController.h"
#import "RimDetailController.h"
#import "LabeledValueCell.h"
#import "PickerController.h"

@interface WheelDetailController : UITableViewController {
    Wheel *wheel;
    LabeledValueCell *rimCell;
    LabeledValueCell *hubCell;
    LabeledValueCell *spokeCountCell;
    LabeledValueCell *spokePatternCell;
    LabeledValueCell *leftLengthCell;
    LabeledValueCell *rightLengthCell;
    HubDetailController *hubDetailController;
    RimDetailController *rimDetailController;
    PickerController *spokeCountPicker;
    PickerController *spokePatternPicker;
    NSArray *sections;

}

@property(nonatomic, retain) Wheel *wheel;
@property(nonatomic, retain) HubDetailController *hubDetailController;
@property(nonatomic, retain) RimDetailController *rimDetailController;

- (void) recalculate;

@end
