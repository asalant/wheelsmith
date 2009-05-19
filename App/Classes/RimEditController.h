#import <UIKit/UIKit.h>
#import "Rim.h"
#import "PartEditDelegate.h"
#import "RimDetailController.h"

@interface RimEditController : UIViewController {
    Rim *rim;
    IBOutlet UITextField *brandTextField;
    IBOutlet UITextField *descriptionTextField;
    IBOutlet UITextField *erdTextField;
    IBOutlet UITextField *offsetTextField;
    IBOutlet UITextField *sizeTextField;
    IBOutlet UITextField *holeCountTextField;
    id currentInput;
    NSArray *textFields;
    id<PartEditDelegate> delegate;
    RimDetailController *detailController;
}

@property(nonatomic, retain) Rim *rim;
@property(nonatomic, retain) UITextField *brandTextField;
@property(nonatomic, retain) UITextField *descriptionTextField;
@property(nonatomic, retain) UITextField *erdTextField;
@property(nonatomic, retain) UITextField *offsetTextField;
@property(nonatomic, retain) UITextField *sizeTextField;
@property(nonatomic, retain) UITextField *holeCountTextField;
@property(nonatomic, retain) id<PartEditDelegate> delegate;
@property(nonatomic, retain) RimDetailController *detailController;

-(IBAction)saveRim;

@end
