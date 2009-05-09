#import <UIKit/UIKit.h>
#import "Rim.h"
#import "EditWheelDelegate.h"

@interface RimDetailController : UIViewController {
    Rim *rim;
    IBOutlet UILabel *brandLabel;
    IBOutlet UILabel *descriptionLabel;
    IBOutlet UILabel *erdLabel;
    IBOutlet UILabel *offsetLabel;
    IBOutlet UILabel *sizeLabel;
    IBOutlet UILabel *holeCountLabel;
    id<EditWheelDelegate> editWheelDelegate;
}

@property(nonatomic, retain) Rim *rim;
@property(nonatomic, retain) UILabel *brandLabel;
@property(nonatomic, retain) UILabel *descriptionLabel;
@property(nonatomic, retain) UILabel *erdLabel;
@property(nonatomic, retain) UILabel *offsetLabel;
@property(nonatomic, retain) UILabel *sizeLabel;
@property(nonatomic, retain) IBOutlet UILabel *holeCountLabel;
@property(nonatomic, retain) id<EditWheelDelegate> editWheelDelegate;

-(IBAction)chooseRim;

@end
