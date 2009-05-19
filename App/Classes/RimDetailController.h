#import <UIKit/UIKit.h>
#import "Rim.h"
#import "EditWheelDelegate.h"
#import "RimEditController.h"

@interface RimDetailController : UIViewController {
    Rim *rim;
    IBOutlet UILabel *brandLabel;
    IBOutlet UILabel *descriptionLabel;
    IBOutlet UILabel *erdLabel;
    IBOutlet UILabel *offsetLabel;
    IBOutlet UILabel *sizeLabel;
    IBOutlet UILabel *holeCountLabel;
    IBOutlet UIButton *deleteButton;
    id<EditWheelDelegate> editWheelDelegate;
    RimEditController *editController;
    BOOL canChoosePart;
}

@property(nonatomic, retain) Rim *rim;
@property(nonatomic, retain) UILabel *brandLabel;
@property(nonatomic, retain) UILabel *descriptionLabel;
@property(nonatomic, retain) UILabel *erdLabel;
@property(nonatomic, retain) UILabel *offsetLabel;
@property(nonatomic, retain) UILabel *sizeLabel;
@property(nonatomic, retain) UILabel *holeCountLabel;
@property(nonatomic, retain) UIButton *deleteButton;
@property(nonatomic, retain) id<EditWheelDelegate> editWheelDelegate;
@property(nonatomic, retain) RimEditController *editController;
@property(nonatomic, assign) BOOL canChoosePart;

-(IBAction)chooseRim;
-(IBAction)deleteRim;

@end
