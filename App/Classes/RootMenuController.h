#import <UIKit/UIKit.h>
#import "BrandListController.h"
#import "MyWheelsController.h"
#import "LabeledValueCell.h"

@interface RootMenuController : UITableViewController {
    NSArray *sections;
    LabeledValueCell *myWheelsCell;
    UITableViewCell *hubsCell;
    UITableViewCell *rimsCell;
    BrandListController *rimBrandListController;
    BrandListController *hubBrandListController;
    MyWheelsController *myWheelsController;
}

@property(nonatomic, retain) LabeledValueCell *myWheelsCell;
@property(nonatomic, retain) UITableViewCell *hubsCell;
@property(nonatomic, retain) UITableViewCell *rimsCell;
@property(nonatomic, retain) BrandListController *rimBrandListController;
@property(nonatomic, retain) BrandListController *hubBrandListController;
@property(nonatomic, retain) MyWheelsController *myWheelsController;

@end
