#import "Rim.h"

@implementation Rim

@synthesize brand, description, size, erd, offset, hole_count;

+ (NSString *)defaultOrderBy {
    return @"brand, description";
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
    [hole_count release];
    [super dealloc];
}
@end

