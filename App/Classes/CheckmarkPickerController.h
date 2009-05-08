#import <UIKit/UIKit.h>
#import "CheckmarkPickerDelegate.h"

@interface CheckmarkPickerController : UITableViewController {
    NSNumber *selectedIndex;
    NSArray *options;
    id<CheckmarkPickerDelegate> delegate;
}

@property(nonatomic, retain) NSNumber *selectedIndex;
@property(nonatomic, retain) NSArray *options;
@property(nonatomic, retain) id selectedOption;
@property(nonatomic, retain) id<CheckmarkPickerDelegate> delegate;

@end
