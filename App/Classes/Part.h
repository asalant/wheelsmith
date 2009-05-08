#import <Foundation/Foundation.h>
#import "DomainObject.h"

@interface Part : DomainObject {
    NSString *brand;
    NSString *description;
}
@property (nonatomic,retain) NSString *brand;
@property (nonatomic,retain) NSString *description;

+ (NSArray *) selectBrandNames;
+ (NSArray *) selectBrandNamesForHoleCount:(NSNumber *)holeCount;

@end
