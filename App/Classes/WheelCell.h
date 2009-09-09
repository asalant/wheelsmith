#import <UIKit/UIKit.h>
#import "Wheel.h"

@interface WheelCell : UITableViewCell {
	IBOutlet UILabel *partsLabel; 
	IBOutlet UILabel *detailLabel; 
    IBOutlet UIImageView *wheelImage;
}

@property(nonatomic, retain) UILabel *partsLabel; 
@property(nonatomic, retain) UILabel *detailLabel; 
@property(nonatomic, retain) UIImageView *wheelImage; 
@property(nonatomic, retain) Wheel *wheel;

@end
