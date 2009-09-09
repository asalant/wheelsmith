#import <UIKit/UIKit.h>


@interface ButtonCell : UITableViewCell {
    IBOutlet UILabel *buttonLabel;
}

@property(nonatomic, retain) UILabel *buttonLabel;

+(ButtonCell *)cellWithLabel:(NSString *)label;

@end
