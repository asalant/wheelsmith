#import "Rim.h"

@implementation Rim

@synthesize brand, description, size, erd, offset, holeCount;


+ (NSDictionary *) dataMap {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSArray arrayWithObjects:@"pk", @"NSNumber", nil], @"id",
            [NSArray arrayWithObjects:@"createdAt", @"NSDate", nil], @"created_at",
            [NSArray arrayWithObjects:@"updatedAt", @"NSDate", nil], @"updated_at",
            [NSArray arrayWithObjects:@"brand", @"NSString", nil], @"brand",
            [NSArray arrayWithObjects:@"description", @"NSString", nil], @"description",
            [NSArray arrayWithObjects:@"size", @"NSNumber", nil], @"size",
            [NSArray arrayWithObjects:@"erd", @"NSNumber", nil], @"erd", 
            [NSArray arrayWithObjects:@"offset", @"NSNumber", nil], @"offset", 
            [NSArray arrayWithObjects:@"holeCount", @"NSNumber", nil], @"hole_count", 
            nil];
}

+ (NSArray *) selectBrandNames {
    return [self select:@"select distinct brand from rims order by brand" rowHandler:@selector(handleBrandRow:)];
}

+ (NSString *) handleBrandRow:(DatabaseResultSet *)result {
    return [result stringAt:0];
}

- (void) dealloc {
    [brand release];
    [description release];
    [size release];
    [erd release];
    [offset release];
    [holeCount release];
    [super dealloc];
}
@end

