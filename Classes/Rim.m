#import "Rim.h"

@implementation Rim

@synthesize pk, brand, description, size, erd, offset, hole_count;

+ (NSString *)defaultOrderBy {
    return @"brand, description";
}

+ (NSString *)selectStatement {
    return @"select id, brand, description, size, erd, offset, hole_count from rims";
}

+ (id) readFromRow:(DatabaseResultSet *)result {
    Rim *rim = [[[Rim alloc] init] autorelease];
    rim.pk = [result integerAt:0];
    rim.brand = [result stringAt:1];
    rim.description = [result stringAt:2];
    rim.size = [result integerAt:3];
    rim.erd = [result doubleAt:4];
    rim.offset = [result doubleAt:5];
    rim.hole_count = [result integerAt:6];   
    return rim;
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

