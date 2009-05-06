#import "DomainObject.h"

@implementation DomainObject

@synthesize pk, createdAt, updatedAt;

-(void)dealloc {
    [pk release];
    [createdAt release];
    [updatedAt release];
    [super dealloc];
}
@end

