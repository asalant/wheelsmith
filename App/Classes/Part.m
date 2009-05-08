#import "Part.h"
#import "DatabaseResultSet.h"

@implementation Part

@synthesize brand, description;


+ (NSArray *) selectBrandNames {
    return [self select:[NSString stringWithFormat:@"select distinct brand from %@ order by brand", 
                         [[[self className] lowercaseString] pluralize]]
             rowHandler:@selector(handleBrandRow:)];
}

+ (NSArray *) selectBrandNamesForHoleCount:(NSNumber *)holeCount {
    if (!holeCount)
        return [self selectBrandNames];
    
    return [self select:[NSString stringWithFormat:@"select distinct brand from %@ where hole_count = %@ order by brand", 
                         [[[self className] lowercaseString] pluralize],
                         holeCount]
             rowHandler:@selector(handleBrandRow:)];
}

+ (NSString *) handleBrandRow:(DatabaseResultSet *)result {
    return [result stringAt:0];
}

- (void) dealloc {
    [brand release];
    [description release];
    [super dealloc];
}
@end
