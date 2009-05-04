#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import "TableCellFactory.h"
#import "RimCell.h"

@interface TableCellFactoryTest : SenTestCase {}

@end


@implementation TableCellFactoryTest

- (void)testCreatesRimCell {
	UITableViewCell *cell = [TableCellFactory createTableCellForClass:[RimCell class] 
															   andNib:@"RimCell"
													   withIdentifier:@"Rim"];
	assertThat(cell, notNilValue());
	assertThat(cell, instanceOf([RimCell class]));
}

- (void)testCantFindUnknownNib {
	UITableViewCell *cell = [TableCellFactory createTableCellForClass:[RimCell class] 
															   andNib:@"FooCell"
													   withIdentifier:@"Rim"];
	assertThat(cell, nilValue());
}
@end
