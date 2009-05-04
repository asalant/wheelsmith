#import <UIKit/UIKit.h>
#import "HubDetailController.h"

@interface HubListController : UITableViewController {
    
    NSArray *hubs;
    HubDetailController *hubDetailController;
}

@property(nonatomic, retain) NSArray *hubs;
@property(nonatomic, retain) HubDetailController *hubDetailController;

@end
