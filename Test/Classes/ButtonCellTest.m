#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>

#import "ButtonCell.h"
#import "TableCellFactory.h"

@interface ButtonCellTest : SenTestCase {}
ButtonCell *cell;
@end

@implementation ButtonCellTest


-(void) testInitializes {
    cell = (ButtonCell*) [TableCellFactory createTableCellForClass:[ButtonCell class] andNib:@"ButtonCell" withIdentifier:@"ButtonCell"];
    assertThat(cell, notNilValue());
    assertThat(cell.buttonLabel, notNilValue());
}


-(void) testCreatesButtonCellWithLabel {
    cell = [ButtonCell cellWithLabel:@"Touch Me"];
    assertThat(cell.buttonLabel.text, is(@"Touch Me"));
}


@end
