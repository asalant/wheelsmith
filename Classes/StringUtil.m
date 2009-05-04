#import "StringUtil.h"

@implementation StringUtil


+ (NSString *) formatFloat:(NSNumber *)number {
    return [NSString stringWithFormat:@"%.1f", [number floatValue]];
}

@end
