#import <UIKit/UIKit.h>

@interface LabeledValueCell : UITableViewCell {
	IBOutlet UILabel *textLabel; 
	IBOutlet UILabel *detailTextLabel;
}

@property(nonatomic, retain) UILabel *textLabel; 
@property(nonatomic, retain) UILabel *detailTextLabel;

+ (LabeledValueCell *) createCell;
+ (LabeledValueCell *) createCellWithLabel:(NSString *)label;
- (void) setValue:(NSString *)value;
@end
