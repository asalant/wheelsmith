#import <Foundation/Foundation.h>


@interface Database : NSObject {
    NSString *dbFilePath;
}

- (id) initWithName:(NSString *)name;
- (NSArray *) select:(NSString *)query delegate:(id)delegate rowHandler:(SEL)selector;

@end
