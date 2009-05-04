#import <UIKit/UIKit.h>
#import "BrandListController.h"
#import "HubListController.h"
#import "Wheel.h"

@interface HubBrandsController : BrandListController {
    HubListController *hubsController;
    Wheel *wheel;
}

@property(nonatomic, retain) HubListController *hubsController;
@property(nonatomic, retain) Wheel *wheel;

@end
