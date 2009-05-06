#import <Foundation/Foundation.h>
#import "DomainObject.h"
#import "DatabaseResultSet.h"

@interface DomainObject (Persistent)

+ (void) setDbName:(NSString *)name;

+ (id)find:(NSNumber *)pk;
+ (NSArray *) findAllOrderBy:(NSString *)order;
+ (id)findFirstByCriteria:(NSString *)criteria orderBy:(NSString *)order;
+ (NSArray *)findByCriteria:(NSString *)criteria orderBy:(NSString *)order;
+ (NSArray *) select:(NSString *)query rowHandler:(SEL)selector;

+(NSDictionary *) dataMap;
+(NSString *) tableName;
+ (id) readFromRow:(DatabaseResultSet *)result;

-(void)create;

@end