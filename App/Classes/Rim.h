#import <Foundation/Foundation.h>
#import "DomainObject+Persistent.h"

@interface Rim : DomainObject {
    NSString *brand;
    NSString *description;
    NSNumber *size;
    NSNumber *erd;
    NSNumber *offset;
    NSNumber *holeCount;
}

@property (nonatomic,retain) NSString *brand;
@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSNumber *size;
@property (nonatomic,retain) NSNumber *erd;
@property (nonatomic,retain) NSNumber *offset;
@property (nonatomic,retain) NSNumber *holeCount;

+ (NSArray *) selectBrandNames;

@end