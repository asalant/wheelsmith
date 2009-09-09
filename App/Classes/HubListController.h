#import <UIKit/UIKit.h>
#import "HubDetailController.h"
#import "HubEditController.h"
#import "Wheel.h"

@interface HubListController : UITableViewController {
    
    NSArray *hubs;
    NSString *brand;
    HubDetailController *hubDetailController;
    HubEditController *editController;
}

@property(nonatomic, retain) NSArray *hubs;
@property(nonatomic, retain) NSString *brand;
@property(nonatomic, retain) HubDetailController *hubDetailController;
@property(nonatomic, retain) HubEditController *editController;

@end
