#import <UIKit/UIKit.h>

@interface LabeledValueCell : UITableViewCell {
	IBOutlet UILabel *labelLabel; 
	IBOutlet UILabel *valueLabel;
}

@property(nonatomic, retain) UILabel *labelLabel; 
@property(nonatomic, retain) UILabel *valueLabel;

+ (LabeledValueCell *) createCell;
+ (LabeledValueCell *) createCellWithLabel:(NSString *)label withValue:(NSString *)value;
- (void) setLabel:(NSString *)label withValue:(NSString *)value;
- (void) setValue:(NSString *)value;
@end
