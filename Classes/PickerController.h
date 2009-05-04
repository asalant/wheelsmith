#import <UIKit/UIKit.h>

@interface PickerController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    
    IBOutlet UIPickerView *pickerView;
    NSArray *options;
    id selectedOption;
    id target;
    SEL handler;
}

@property(nonatomic, retain) UIPickerView *pickerView;
@property(nonatomic, retain) NSArray *options;
@property(nonatomic, retain) id selectedOption;
@property(nonatomic, retain) id target;
@property(nonatomic) SEL handler;


@end
