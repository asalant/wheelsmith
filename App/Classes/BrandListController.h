#import <UIKit/UIKit.h>

@interface BrandListController : UITableViewController {
    NSArray *brands;
    NSNumber *holeCount;
}

@property(nonatomic, retain) NSArray *brands;
@property(nonatomic, retain) NSNumber *holeCount;

@end
