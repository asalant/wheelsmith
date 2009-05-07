#import <UIKit/UIKit.h>
#import "WheelDetailController.h"
#import "WheelDetailDelegate.h"

@interface MyWheelsController : UITableViewController <WheelDetailDelegate> {
    NSArray *wheels;
    WheelDetailController *wheelDetailController;
    UINavigationController *newWheelController;
}

@property(nonatomic, retain) NSArray *wheels;
@property(nonatomic, retain) WheelDetailController *wheelDetailController;
@property(nonatomic, retain) UINavigationController *newWheelController;

@end
