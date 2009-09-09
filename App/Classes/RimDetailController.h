#import <UIKit/UIKit.h>
#import "Rim.h"
#import "LabeledValueCell.h"
#import "EditWheelDelegate.h"

@interface RimDetailController : UITableViewController {
    Rim *rim;
    NSArray *sections;
    LabeledValueCell *brandCell;
    LabeledValueCell *descriptionCell;
    LabeledValueCell *erdCell;
    LabeledValueCell *offsetCell;
    LabeledValueCell *sizeCell;
    LabeledValueCell *holeCountCell;
    id<EditWheelDelegate> editWheelDelegate;
    BOOL canChoosePart;
}

@property(nonatomic, retain) Rim *rim;
@property(nonatomic, retain) id<EditWheelDelegate> editWheelDelegate;
@property(nonatomic, assign) BOOL canChoosePart;

-(IBAction)chooseRim;

@end
