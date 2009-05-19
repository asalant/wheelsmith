#import <Foundation/Foundation.h>
#import "DomainObject.h"

@interface Part : DomainObject {
    NSString *brand;
    NSString *description;
    NSNumber *verified;
}
@property (nonatomic,retain) NSString *brand;
@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSNumber *verified;

+ (NSArray *) findByBrand:(NSString *)brand andHoleCount:(NSNumber *)holeCount;
+ (NSArray *) selectBrandNames;
+ (NSArray *) selectBrandNamesForHoleCount:(NSNumber *)holeCount;

@end
