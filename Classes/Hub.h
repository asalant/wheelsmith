#import <Foundation/Foundation.h>
#import "DomainObject+Persistent.h"

@interface Hub : DomainObject {
    NSNumber *pk;
    NSString *brand;
    NSString *description;
    NSNumber *leftFlangeDiameter;
    NSNumber *leftFlangeToCenter;
    NSNumber *rightFlangeDiameter;
    NSNumber *rightFlangeToCenter;
    BOOL rear;
    NSNumber *holeCount;
}
@property (nonatomic,retain) NSNumber *pk;
@property (nonatomic,retain) NSString *brand;
@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSNumber *leftFlangeDiameter;
@property (nonatomic,retain) NSNumber *leftFlangeToCenter;
@property (nonatomic,retain) NSNumber *rightFlangeDiameter;
@property (nonatomic,retain) NSNumber *rightFlangeToCenter;
@property BOOL rear;
@property (nonatomic,retain) NSNumber *holeCount;

+ (NSArray *) selectBrandNames;

@end