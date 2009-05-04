#import <UIKit/UIKit.h>
#import "RimDetailController.h"
#import "Wheel.h"

@interface RimListController : UITableViewController {

    NSArray *rims;
    Wheel *wheel;
    RimDetailController *rimDetailController;
}

@property(nonatomic, retain) NSArray *rims;
@property(nonatomic, retain) Wheel *wheel;
@property(nonatomic, retain) RimDetailController *rimDetailController;

@end
