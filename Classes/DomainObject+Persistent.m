#import "DomainObject+Persistent.h"
#import "Database.h"
#import "DatabaseResultSet.h"

static Database *database;

@implementation DomainObject (Persistent)

+ (void) setDbName:(NSString *)name {
    database = [[Database alloc] initWithName:name];
}

+ (NSArray *) findAll {
    return [self findByCriteria:@"1=1" orderBy:[self defaultOrderBy]];
}

+ (NSArray *)findByCriteria:(NSString *)criteria orderBy:(NSString *)order {
    NSString *query = [NSString stringWithFormat:@"%@ WHERE %@ ORDER BY %@", [self selectStatement], criteria, order];
    return [self select:query rowHandler:@selector(readFromRow:)];
}

+ (id)findFirstByCriteria:(NSString *)criteria orderBy:(NSString *)order {
    NSArray *results =  [self findByCriteria:criteria orderBy:order];
    if (results.count == 0) 
        return nil;
    else
        return [results objectAtIndex:0];
}

+ (NSArray *) select:(NSString *)query rowHandler:(SEL)selector {
    return [database select:query delegate:self rowHandler:selector];
}

+ (NSString *) selectStatement {
    @throw [NSException exceptionWithName:@"PersistenceException"
                                   reason:[NSString stringWithFormat:@"You must implement '+ (NSString *) selectStatement' in %@", [self class]]
                                 userInfo:nil];
}

+ (id) readFromRow:(DatabaseResultSet *)result {
    @throw [NSException exceptionWithName:@"PersistenceException"
                                   reason:[NSString stringWithFormat:@"You must implement '+ (id) readFromRow:(DatabaseResultSet *)result in %@", [self class]]
                                 userInfo:nil];
}

+ (NSString *) defaultOrderBy {
    @throw [NSException exceptionWithName:@"PersistenceException"
                                   reason:[NSString stringWithFormat:@"You must implement '+ (NSString *) defaultOrderBy' in %@", [self class]]
                                 userInfo:nil];
}


@end
    
