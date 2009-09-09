#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>

#import "Wheel.h"
#import "WheelCell.h"
#import "TableCellFactory.h"

@interface WheelCellTest : SenTestCase {}
Wheel *wheel;
WheelCell *cell;
@end

@implementation WheelCellTest

-(void) setUp {
    Wheel *wheel = [[[Wheel alloc] init] autorelease];
    wheel.spokePattern = [NSNumber numberWithInt:0];
    
    Rim *rim = [[[Rim alloc] init] autorelease];
    rim.brand = @"Mavic";
    rim.description = @"Open Pro";
    rim.size = [NSNumber numberWithInt:622];
    rim.holeCount = [NSNumber numberWithInt:32];
    wheel.rim = rim;
    
    Hub *hub = [[[Hub alloc] init] autorelease];
    hub.brand = @"Campagnolo";
    hub.description = @"Record";
    hub.rear = [NSNumber numberWithBool:YES];
    wheel.hub = hub;

    cell = (WheelCell*) [TableCellFactory createTableCellForClass:[WheelCell class] andNib:@"WheelCell" withIdentifier:@"Wheel"];
    cell.wheel = wheel;
}

-(void) testInitializes {
    assertThat(cell, notNilValue());
    assertThat(cell.partsLabel, notNilValue());
    assertThat(cell.detailLabel, notNilValue());
//    assertThat(cell.wheelImage, notNilValue());
}

-(void) testFormatsPartsLabel {
    assertThat(cell.partsLabel.text, is(@"Campagnolo / Mavic"));
}

-(void) testFormatsDetailLabel {
    assertThat(cell.detailLabel.text, is(@"radial, 32h, 700c, rear"));
}

-(void) testPopulatesLabelsWithNils {
    
    Wheel *wheel = [[[Wheel alloc] init] autorelease];
    
    cell.wheel = wheel;
    assertThat(cell.partsLabel.text, is(@"? / ?"));
    assertThat(cell.detailLabel.text, is(@""));
}

@end
