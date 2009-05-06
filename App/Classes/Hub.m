#import "Hub.h"
#import "DatabaseResultSet.h"

@implementation Hub

@synthesize brand, description, leftFlangeDiameter, leftFlangeToCenter;
@synthesize rightFlangeDiameter, rightFlangeToCenter, rear, holeCount;

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
