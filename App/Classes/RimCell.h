#import <UIKit/UIKit.h>
#import "Rim.h"

@interface RimCell : UITableViewCell {
	IBOutlet UILabel *descriptionLabel; 
	IBOutlet UILabel *sizeLabel; 
	IBOutlet UILabel *holeCountLabel; 
}

@property(nonatomic, retain) UILabel *descriptionLabel; 
@property(nonatomic, retain) UILabel *sizeLabel; 
@property(nonatomic, retain) UILabel *holeCountLabel; 
@property(nonatomic, retain) Rim *rim;

@end
