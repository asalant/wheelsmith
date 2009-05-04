#import <UIKit/UIKit.h>
#import "WheelDetailController.h"

@interface MyWheelsController : UITableViewController {
    NSArray *wheels;
    WheelDetailController *wheelDetailController;
}

@property(nonatomic, retain) NSArray *wheels;
@property(nonatomic, retain) WheelDetailController *wheelDetailController;

@end
