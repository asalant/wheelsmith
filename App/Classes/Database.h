#import <Foundation/Foundation.h>


@interface Database : NSObject {
    NSString *dbFilePath;
}

+(Database *)create:(NSString *)name overwrite:(BOOL)overwrite;

- (id) initWithName:(NSString *)name;
- (NSArray *) execute:(NSString *)query delegate:(id)delegate rowHandler:(SEL)selector;

@end
