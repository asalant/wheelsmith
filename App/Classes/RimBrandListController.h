#import <UIKit/UIKit.h>
#import "BrandListController.h"
#import "RimListController.h"


@interface RimBrandListController : BrandListController {
    RimListController *rimListController;
}

@property(nonatomic, retain) RimListController *rimListController;

@end
