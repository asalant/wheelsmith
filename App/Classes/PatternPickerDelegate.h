#import <UIKit/UIKit.h>
#import "CheckmarkPickerDelegate.h"
#import "EditWheelDelegate.h"

@class WheelDetailController;

@interface PatternPickerDelegate : NSObject <CheckmarkPickerDelegate> {
    NSDictionary *options;
    id<EditWheelDelegate> editWheelDelegate;
}

@property(nonatomic, assign)  id<EditWheelDelegate> editWheelDelegate;

@end
