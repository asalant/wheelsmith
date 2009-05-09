#import <UIKit/UIKit.h>
#import "HubDetailController.h"
#import "Wheel.h"

@interface HubListController : UITableViewController {
    
    NSArray *hubs;
    HubDetailController *hubDetailController;
}

@property(nonatomic, retain) NSArray *hubs;
@property(nonatomic, retain) HubDetailController *hubDetailController;

@end
