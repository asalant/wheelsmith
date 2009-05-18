#import <UIKit/UIKit.h>
#import "RimDetailController.h"
#import "Wheel.h"

@interface RimListController : UITableViewController {

    NSArray *rims;
    RimDetailController *rimDetailController;
    RimEditController *editController;
}

@property(nonatomic, retain) NSArray *rims;
@property(nonatomic, retain) RimEditController *editController;
@property(nonatomic, retain) RimDetailController *rimDetailController;

@end
