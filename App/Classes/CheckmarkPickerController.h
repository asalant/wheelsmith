#import <UIKit/UIKit.h>
#import "CheckmarkPickerDelegate.h"

@interface CheckmarkPickerController : UITableViewController {
    int selectedIndex;
    NSArray *options;
    id<CheckmarkPickerDelegate> delegate;
}

@property(nonatomic, assign) int selectedIndex;
@property(nonatomic, readonly) id selectedOption;
@property(nonatomic, retain) NSArray *options;
@property(nonatomic, retain) id<CheckmarkPickerDelegate> delegate;

@end
