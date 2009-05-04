#import <Foundation/Foundation.h>


@interface TableCellFactory : NSObject {

}
+ (UITableViewCell *)createTableCellForClass:(Class)cellClass 
									 andNib:(NSString *)nibName 
							  withIdentifier:(NSString *)identifier;
@end
