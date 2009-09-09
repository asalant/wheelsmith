#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>

#import "Rim.h"
#import "RimCell.h"
#import "TableCellFactory.h"

@interface RimCellTest : SenTestCase {}
RimCell *cell;
@end

@implementation RimCellTest

-(void) setUp {
    cell = (RimCell*) [TableCellFactory createTableCellForClass:[RimCell class] andNib:@"RimCell" withIdentifier:@"Rim"];
}

-(void) testInitializes {
    assertThat(cell, notNilValue());
    assertThat(cell.descriptionLabel, notNilValue());
    assertThat(cell.sizeLabel, notNilValue());
    assertThat(cell.holeCountLabel, notNilValue());
}

-(void) testPopulatesLabelsWithValues {
    
    Rim *rim = [[[Rim alloc] init] autorelease];
    rim.description = @"Description";
    rim.size = [NSNumber numberWithInt:381];
    rim.holeCount = [NSNumber numberWithInt:32];
    
    cell.rim = rim;
    assertThat(cell.descriptionLabel.text, is(@"Description"));
    assertThat(cell.sizeLabel.text, is(@"19\""));
    assertThat(cell.holeCountLabel.text, is(@"32h"));
}

-(void) testPopulatesLabelsWithNils {
    
    Rim *rim = [[[Rim alloc] init] autorelease];
    
    cell.rim = rim;
    assertThat(cell.descriptionLabel.text, nilValue());
    assertThat(cell.sizeLabel.text, nilValue());
    assertThat(cell.holeCountLabel.text, nilValue());
}

@end
