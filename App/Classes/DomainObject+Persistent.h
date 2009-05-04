#import <Foundation/Foundation.h>
#import "DomainObject.h"
#import "DatabaseResultSet.h"

@interface DomainObject (Persistent)

+ (void) setDbName:(NSString *)name;

+ (NSArray *) findAll;
+ (id)findFirstByCriteria:(NSString *)criteria orderBy:(NSString *)order;
+ (NSArray *)findByCriteria:(NSString *)criteria orderBy:(NSString *)order;
+ (NSArray *) select:(NSString *)query rowHandler:(SEL)selector;


+ (NSString *) selectStatement;
+ (id) readFromRow:(DatabaseResultSet *)result;
+ (NSString *) defaultOrderBy;

@end