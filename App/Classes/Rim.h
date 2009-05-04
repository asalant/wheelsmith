#import <Foundation/Foundation.h>
#import "DomainObject+Persistent.h"

@interface Rim : DomainObject {
    NSNumber *pk;
    NSString *brand;
    NSString *description;
    NSNumber *size;
    NSNumber *erd;
    NSNumber *offset;
    NSNumber *hole_count;
}
@property (nonatomic,retain) NSNumber *pk;
@property (nonatomic,retain) NSString *brand;
@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSNumber *size;
@property (nonatomic,retain) NSNumber *erd;
@property (nonatomic,retain) NSNumber *offset;
@property (nonatomic,retain) NSNumber *hole_count;

+ (NSArray *) selectBrandNames;

@end