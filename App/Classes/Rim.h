#import <Foundation/Foundation.h>
#import "Part.h"

@interface Rim : Part {
    NSNumber *size;
    NSNumber *erd;
    NSNumber *offset;
    NSNumber *holeCount;
}

@property (nonatomic,retain) NSNumber *size;
@property (nonatomic,retain) NSNumber *erd;
@property (nonatomic,retain) NSNumber *offset;
@property (nonatomic,retain) NSNumber *holeCount;
@property (nonatomic, readonly) NSString *sizeDescription;

@end