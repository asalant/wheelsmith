#import <UIKit/UIKit.h>
#import "BrandListController.h"
#import "HubListController.h"


@interface HubBrandListController : BrandListController {
    HubListController *hubListController;
}

@property(nonatomic, retain) HubListController *hubListController;

@end
