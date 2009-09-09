#import "TableCellFactory.h"

@implementation TableCellFactory

+ (UITableViewCell *) createTableCellForClass:(Class)cellClass 
                                       andNib:(NSString *)nibName 
                               withIdentifier:(NSString *)identifier {
	NSArray* nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil]; 
    for (id nibItem in nibContents) {
        if ([nibItem isKindOfClass:cellClass] && [[(UITableViewCell *)nibItem reuseIdentifier] isEqualToString: identifier]) {
            return (UITableViewCell *) nibItem;
        }
    }
    return nil;
}



@end
