#import "SqliteDateFormatter.h"

SqliteDateFormatter *sharedInstance;

@implementation SqliteDateFormatter

+(SqliteDateFormatter *)sharedFormatter {
    if (!sharedInstance) {
        sharedInstance = [[[SqliteDateFormatter alloc] init] retain];
    }
    return sharedInstance;
}

-(id)init {
    if (self = [super init]) {
        [self setFormatterBehavior:NSDateFormatterBehavior10_4];
        [self setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return self;
}

@end
