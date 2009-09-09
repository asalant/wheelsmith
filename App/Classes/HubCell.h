#import <UIKit/UIKit.h>
#import "Hub.h"

@interface HubCell : UITableViewCell {
	IBOutlet UILabel *descriptionLabel; 
	IBOutlet UILabel *rearLabel; 
	IBOutlet UILabel *holeCountLabel; 
}

@property(nonatomic, retain) UILabel *descriptionLabel; 
@property(nonatomic, retain) UILabel *rearLabel; 
@property(nonatomic, retain) UILabel *holeCountLabel; 
@property(nonatomic, retain) Hub *hub;

@end
