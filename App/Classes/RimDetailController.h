#import <UIKit/UIKit.h>
#import "Rim.h"
#import "EditWheelDelegate.h"

@interface RimDetailController : UIViewController {
    Rim *rim;
    IBOutlet UILabel *brandLabel;
    IBOutlet UILabel *descriptionLabel;
    IBOutlet UILabel *erdLabel;
    IBOutlet UILabel *offsetLabel;
    IBOutlet UILabel *isoLabel;
    IBOutlet UILabel *sizeLabel;
    IBOutlet UITextView *notesTextView;
    IBOutlet UILabel *verifiedLabel;
    id<EditWheelDelegate> editWheelDelegate;
}

@property(nonatomic, retain) Rim *rim;
@property(nonatomic, retain) UILabel *brandLabel;
@property(nonatomic, retain) UILabel *descriptionLabel;
@property(nonatomic, retain) UILabel *erdLabel;
@property(nonatomic, retain) UILabel *offsetLabel;
@property(nonatomic, retain) UILabel *isoLabel;
@property(nonatomic, retain) UILabel *sizeLabel;
@property(nonatomic, retain) UITextView *notesTextView;
@property(nonatomic, retain) UILabel *verifiedLabel;
@property(nonatomic, retain) id<EditWheelDelegate> editWheelDelegate;

-(IBAction)chooseRim;

@end
