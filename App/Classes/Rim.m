#import "Rim.h"

@implementation Rim

@synthesize size, erd, offset, holeCount;


+ (NSDictionary *) dataMap {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSArray arrayWithObjects:@"pk", @"integer", nil], @"id",
            [NSArray arrayWithObjects:@"createdAt", @"datetime", nil], @"created_at",
            [NSArray arrayWithObjects:@"updatedAt", @"datetime", nil], @"updated_at",
            [NSArray arrayWithObjects:@"brand", @"string", nil], @"brand",
            [NSArray arrayWithObjects:@"description", @"string", nil], @"description",
            [NSArray arrayWithObjects:@"size", @"integer", nil], @"size",
            [NSArray arrayWithObjects:@"erd", @"float", nil], @"erd", 
            [NSArray arrayWithObjects:@"offset", @"float", nil], @"offset", 
            [NSArray arrayWithObjects:@"holeCount", @"integer", nil], @"hole_count", 
            nil];
}

- (void) dealloc {
    [size release];
    [erd release];
    [offset release];
    [holeCount release];
    [super dealloc];
}
@end

