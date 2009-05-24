#import <Foundation/Foundation.h>


@interface SqliteDateFormatter : NSDateFormatter {
}

+(SqliteDateFormatter *)sharedFormatter;

@end
