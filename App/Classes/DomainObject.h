#import <Foundation/Foundation.h>
#import "CoreSupport.h"

@interface DomainObject : NSObject {
    NSNumber *pk;
    NSDate *createdAt;
    NSDate *updatedAt;
}

@property(nonatomic, retain) NSNumber *pk;
@property(nonatomic, retain) NSDate *updatedAt;
@property(nonatomic, retain) NSDate *createdAt;

@end


