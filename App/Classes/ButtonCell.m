#import "ButtonCell.h"
#import "TableCellFactory.h"


@implementation ButtonCell

@synthesize buttonLabel;

+(ButtonCell *)cellWithLabel:(NSString *)label {
    ButtonCell *cell = (ButtonCell*) [TableCellFactory createTableCellForClass:[ButtonCell class] andNib:@"ButtonCell" withIdentifier:@"ButtonCell"];
    cell.buttonLabel.text = label;
    return cell;
}


- (void)dealloc {
    [buttonLabel release];
    [super dealloc];
}


@end
