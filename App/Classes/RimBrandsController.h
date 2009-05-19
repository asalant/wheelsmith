#import <UIKit/UIKit.h>
#import "BrandListController.h"
#import "RimListController.h"
#import "Wheel.h"

@interface RimBrandsController : BrandListController {
    RimEditController *editController;
    RimListController *rimsController;
    Wheel *wheel;
}

@property(nonatomic, retain) RimEditController *editController;
@property(nonatomic, retain) RimListController *rimsController;
@property(nonatomic, retain) Wheel *wheel;

@end
