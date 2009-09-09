#import <UIKit/UIKit.h>
#import "BrandListController.h"
#import "HubListController.h"
#import "HubEditController.h"
#import "Wheel.h"

@interface HubBrandsController : BrandListController {
    HubListController *hubsController;
    HubEditController *editController;
    Wheel *wheel;
}

@property(nonatomic, retain) HubListController *hubsController;
@property(nonatomic, retain) HubEditController *editController;
@property(nonatomic, retain) Wheel *wheel;

@end
