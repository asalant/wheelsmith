#import <Foundation/Foundation.h>
#import "CoreSupport.h"
#import "DatabaseResultSet.h"
#import "Database.h"

@interface DomainObject : NSObject {
    NSNumber *pk;
    NSDate *createdAt;
    NSDate *updatedAt;
}

@property(nonatomic, retain) NSNumber *pk;
@property(nonatomic, retain) NSDate *updatedAt;
@property(nonatomic, retain) NSDate *createdAt;

+ (void) setDatabase:(Database *)theDatabase;
+ (id)find:(NSNumber *)pk;
+ (NSArray *) findAllOrderBy:(NSString *)order;
+ (id)findFirstByCriteria:(NSString *)criteria orderBy:(NSString *)order;
+ (NSArray *)findByCriteria:(NSString *)criteria orderBy:(NSString *)order;
+ (NSArray *) select:(NSString *)query rowHandler:(SEL)selector;

+(NSDictionary *) dataMap;
+(NSString *) tableName;
+ (id) readFromRow:(DatabaseResultSet *)result;

-(void)create;
-(void)update;
-(void)save;
-(void)delete;
-(NSArray *)propertyValuesForColumns:(NSArray *)columnNames;

@end


