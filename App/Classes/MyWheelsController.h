#import <UIKit/UIKit.h>
#import "WheelDetailController.h"
#import "WheelDetailDelegate.h"

@interface MyWheelsController : UITableViewController <WheelDetailDelegate> {
    NSMutableArray *wheels;
    WheelDetailController *wheelDetailController;
    UINavigationController *newWheelController;
}

@property(nonatomic, retain) NSMutableArray *wheels;
@property(nonatomic, retain) WheelDetailController *wheelDetailController;
@property(nonatomic, retain) UINavigationController *newWheelController;

@end
