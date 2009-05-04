#import <UIKit/UIKit.h>
#import "WheelDetailController.h"

@interface MyWheelsController : UITableViewController {
    NSArray *wheels;
    WheelDetailController *wheelDetailController;
    UINavigationController *newWheelController;
}

@property(nonatomic, retain) NSArray *wheels;
@property(nonatomic, retain) WheelDetailController *wheelDetailController;
@property(nonatomic, retain) UINavigationController *newWheelController;

@end
