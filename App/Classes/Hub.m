#import "Hub.h"
#import "DatabaseResultSet.h"

@implementation Hub

@synthesize pk, brand, description, leftFlangeDiameter, leftFlangeToCenter;
@synthesize rightFlangeDiameter, rightFlangeToCenter, rear, holeCount;


+ (NSString *)defaultOrderBy {
    return @"brand, description";
}

+ (NSString *)selectStatement {
    return @"select id, brand, description, rear, left_flange_diameter, left_flange_to_center, right_flange_diameter, right_flange_to_center, hole_count from hubs";
}

+ (id) readFromRow:(DatabaseResultSet *)result {
    Hub *hub = [[[Hub alloc] init] autorelease];
    hub.pk = [result integerAt:0];
    hub.brand = [result stringAt:1];
    hub.description = [result stringAt:2];
    hub.rear = [result booleanAt:3];
    hub.leftFlangeDiameter = [result doubleAt:4];
    hub.leftFlangeToCenter = [result doubleAt:5];
    hub.rightFlangeDiameter = [result doubleAt:6];
    hub.rightFlangeToCenter = [result doubleAt:7];
    hub.holeCount = [result integerAt:8];
    return hub;
}

+ (NSArray *) selectBrandNames {
    return [self select:@"select distinct brand from hubs order by brand" rowHandler:@selector(handleBrandRow:)];
}

+ (NSString *) handleBrandRow:(DatabaseResultSet *)result {
    return [result stringAt:0];
}

- (void) dealloc {
    [description release];
    [super dealloc];
}

@end
