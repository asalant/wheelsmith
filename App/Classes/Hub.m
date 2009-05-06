#import "Hub.h"
#import "DatabaseResultSet.h"

@implementation Hub

@synthesize brand, description, leftFlangeDiameter, leftFlangeToCenter;
@synthesize rightFlangeDiameter, rightFlangeToCenter, rear, holeCount;

+ (NSDictionary *) dataMap {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSArray arrayWithObjects:@"pk", @"NSNumber", nil], @"id",
            [NSArray arrayWithObjects:@"createdAt", @"NSDate", nil], @"created_at",
            [NSArray arrayWithObjects:@"updatedAt", @"NSDate", nil], @"updated_at",
            [NSArray arrayWithObjects:@"brand", @"NSString", nil], @"brand",
            [NSArray arrayWithObjects:@"description", @"NSString", nil], @"description",
            [NSArray arrayWithObjects:@"leftFlangeDiameter", @"NSNumber", nil], @"left_flange_diameter",
            [NSArray arrayWithObjects:@"leftFlangeToCenter", @"NSNumber", nil], @"left_flange_to_center",
            [NSArray arrayWithObjects:@"rightFlangeDiameter", @"NSNumber", nil], @"right_flange_diameter",
            [NSArray arrayWithObjects:@"rightFlangeToCenter", @"NSNumber", nil], @"right_flange_to_center", 
            [NSArray arrayWithObjects:@"rear", @"BOOL", nil], @"rear", 
            [NSArray arrayWithObjects:@"holeCount", @"NSNumber", nil], @"hole_count", 
            nil];
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
