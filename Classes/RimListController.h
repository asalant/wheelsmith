#import <UIKit/UIKit.h>
#import "RimDetailController.h"

@interface RimListController : UITableViewController {

    NSArray *rims;
    RimDetailController *rimDetailController;
}

@property(nonatomic, retain) NSArray *rims;
@property(nonatomic, retain) RimDetailController *rimDetailController;

@end
