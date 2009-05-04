#import <UIKit/UIKit.h>
#import "BrandListController.h"
#import "RimListController.h"
#import "Wheel.h"

@interface RimBrandsController : BrandListController {
    RimListController *rimsController;
    Wheel *wheel;
}

@property(nonatomic, retain) RimListController *rimsController;
@property(nonatomic, retain) Wheel *wheel;

@end
