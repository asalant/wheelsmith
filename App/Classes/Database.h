#import <Foundation/Foundation.h>


@interface Database : NSObject {
    NSString *dbFilePath;
}

+(NSString *)sqlDate:(NSDate *)date;

- (id) initWithName:(NSString *)name;
- (NSArray *) execute:(NSString *)query delegate:(id)delegate rowHandler:(SEL)selector;

@end
