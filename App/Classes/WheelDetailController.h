#import <UIKit/UIKit.h>
#import "Wheel.h"
#import "HubDetailController.h"
#import "RimDetailController.h"
#import "HubBrandsController.h"
#import "RimBrandsController.h"
#import "LabeledValueCell.h"
#import "CheckmarkPickerController.h"
#import "EditWheelDelegate.h"
#import "WheelDetailDelegate.h"
#import "CheckmarkPickerDelegate.h"

@interface WheelDetailController : UITableViewController <EditWheelDelegate, CheckmarkPickerDelegate> {
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
    CheckmarkPickerController *spokePatternPicker;
    id<WheelDetailDelegate> delegate;
    NSArray *sections;
    NSDictionary *patternPickerOptions;
    BOOL editing;

}

@property(nonatomic, retain) Wheel *wheel;
@property(nonatomic, retain) HubDetailController *hubDetailController;
@property(nonatomic, retain) RimDetailController *rimDetailController;
@property(nonatomic, retain) HubBrandsController *hubBrandsController;
@property(nonatomic, retain) RimBrandsController *rimBrandsController;
@property(nonatomic, retain) id<WheelDetailDelegate> delegate;
@property(nonatomic, assign) BOOL editing;

- (void) updateView;
- (void) enableEdit;
- (void) disableEdit;

@end
