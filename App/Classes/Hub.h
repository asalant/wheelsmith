#import <Foundation/Foundation.h>
#import "DomainObject.h"

@interface Hub : DomainObject {
    NSString *brand;
    NSString *description;
    NSNumber *leftFlangeDiameter;
    NSNumber *leftFlangeToCenter;
    NSNumber *rightFlangeDiameter;
    NSNumber *rightFlangeToCenter;
    NSNumber *rear;
    NSNumber *holeCount;
}

@property (nonatomic,retain) NSString *brand;
@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSNumber *leftFlangeDiameter;
@property (nonatomic,retain) NSNumber *leftFlangeToCenter;
@property (nonatomic,retain) NSNumber *rightFlangeDiameter;
@property (nonatomic,retain) NSNumber *rightFlangeToCenter;
@property (nonatomic,retain) NSNumber *rear;
@property (nonatomic,retain) NSNumber *holeCount;

+ (NSArray *) selectBrandNames;

@end