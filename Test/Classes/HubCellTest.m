#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>

#import "Hub.h"
#import "HubCell.h"
#import "TableCellFactory.h"

@interface HubCellTest : SenTestCase {}
HubCell *cell;
@end

@implementation HubCellTest

-(void) setUp {
    cell = (HubCell*) [TableCellFactory createTableCellForClass:[HubCell class] andNib:@"HubCell" withIdentifier:@"Hub"];
}

-(void) testInitializes {
    assertThat(cell, notNilValue());
    assertThat(cell.descriptionLabel, notNilValue());
    assertThat(cell.rearLabel, notNilValue());
    assertThat(cell.holeCountLabel, notNilValue());
}

-(void) testPopulatesLabelsWithValues {
    
    Hub *hub = [[[Hub alloc] init] autorelease];
    hub.description = @"Description";
    hub.rear = [NSNumber numberWithBool:YES];
    hub.holeCount = [NSNumber numberWithInt:32];
    
    cell.hub = hub;
    assertThat(cell.descriptionLabel.text, is(@"Description"));
    assertThat(cell.rearLabel.text, is(@"rear"));
    assertThat(cell.holeCountLabel.text, is(@"32h"));
}

-(void) testPopulatesLabelsWithNils {
    
    Hub *hub = [[[Hub alloc] init] autorelease];
    
    cell.hub = hub;
    assertThat(cell.descriptionLabel.text, nilValue());
    assertThat(cell.rearLabel.text, is(@"front"));
    assertThat(cell.holeCountLabel.text, nilValue());
}

@end
