#import "Hub.h"

@implementation Hub

@synthesize leftFlangeDiameter, leftFlangeToCenter;
@synthesize rightFlangeDiameter, rightFlangeToCenter, rear, holeCount;

+ (NSDictionary *) dataMap {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSArray arrayWithObjects:@"pk", @"integer", nil], @"id",
            [NSArray arrayWithObjects:@"createdAt", @"datetime", nil], @"created_at",
            [NSArray arrayWithObjects:@"updatedAt", @"datetime", nil], @"updated_at",
            [NSArray arrayWithObjects:@"brand", @"string", nil], @"brand",
            [NSArray arrayWithObjects:@"description", @"string", nil], @"description",
            [NSArray arrayWithObjects:@"leftFlangeDiameter", @"float", nil], @"left_flange_diameter",
            [NSArray arrayWithObjects:@"leftFlangeToCenter", @"float", nil], @"left_flange_to_center",
            [NSArray arrayWithObjects:@"rightFlangeDiameter", @"float", nil], @"right_flange_diameter",
            [NSArray arrayWithObjects:@"rightFlangeToCenter", @"float", nil], @"right_flange_to_center", 
            [NSArray arrayWithObjects:@"rear", @"boolean", nil], @"rear", 
            [NSArray arrayWithObjects:@"holeCount", @"integer", nil], @"hole_count", 
            nil];
}

- (void) dealloc {
    [super dealloc];
}

@end
