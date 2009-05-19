#import <UIKit/UIKit.h>
#import "PartEditDelegate.h"

@interface BrandListController : UITableViewController <PartEditDelegate> {
    NSArray *brands;
    NSNumber *holeCount;
}

@property(nonatomic, retain) NSArray *brands;
@property(nonatomic, retain) NSNumber *holeCount;

@end
