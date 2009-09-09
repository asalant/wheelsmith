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
            [NSArray arrayWithObjects:@"verified", @"boolean", nil], @"verified", 
            [NSArray arrayWithObjects:@"size", @"integer", nil], @"size",
            [NSArray arrayWithObjects:@"erd", @"float", nil], @"erd", 
            [NSArray arrayWithObjects:@"offset", @"float", nil], @"offset", 
            [NSArray arrayWithObjects:@"holeCount", @"integer", nil], @"hole_count", 
            nil];
}

-(NSString *)sizeDescription {
    NSDictionary *sizeDescriptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"19\"", [NSNumber numberWithInt:381],
                                      @"20\"", [NSNumber numberWithInt:406],
                                      @"20\"", [NSNumber numberWithInt:451],
                                      @"24\"", [NSNumber numberWithInt:507],
                                      @"24\"", [NSNumber numberWithInt:520],
                                      @"26\"", [NSNumber numberWithInt:559],
                                      @"650c", [NSNumber numberWithInt:571],
                                      @"650c", [NSNumber numberWithInt:590],
                                      @"700c", [NSNumber numberWithInt:622],
                                      @"27\"", [NSNumber numberWithInt:630],
                                      nil];
    return [sizeDescriptions objectForKey:[self size]];
}

- (void) dealloc {
    [size release];
    [erd release];
    [offset release];
    [holeCount release];
    [super dealloc];
}
@end

