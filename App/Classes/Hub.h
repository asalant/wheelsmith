#import <Foundation/Foundation.h>
#import "Part.h"

@interface Hub : Part {
    NSNumber *leftFlangeDiameter;
    NSNumber *leftFlangeToCenter;
    NSNumber *rightFlangeDiameter;
    NSNumber *rightFlangeToCenter;
    NSNumber *rear;
    NSNumber *holeCount;
}

@property (nonatomic,retain) NSNumber *leftFlangeDiameter;
@property (nonatomic,retain) NSNumber *leftFlangeToCenter;
@property (nonatomic,retain) NSNumber *rightFlangeDiameter;
@property (nonatomic,retain) NSNumber *rightFlangeToCenter;
@property (nonatomic,retain) NSNumber *rear;
@property (nonatomic,retain) NSNumber *holeCount;

@end