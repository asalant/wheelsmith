#import "DomainObject+Persistent.h"
#import "Database.h"
#import "DatabaseResultSet.h"

static Database *database;

@implementation DomainObject (Persistent)

+ (void) setDbName:(NSString *)name {
    database = [[Database alloc] initWithName:name];
}

+ (NSDictionary *) dataMap {
    NSMutableDictionary *dataMap = [NSMutableDictionary dictionary];
    for (id name in [self propertyNames]) {
        if ([name isEqual:@"pk"])
            [dataMap setValue:@"pk" forKey:@"id"];
        else
            [dataMap setValue:name forKey:[name underscore]];
    }
    return dataMap;
}

+ (NSString *) tableName {
    return [[[self className] lowercaseString] pluralize];
}

+ (NSArray *) findAllOrderBy:(NSString *)order {
    return [self findByCriteria:nil orderBy:order];
}

+ (id) find:(NSNumber *)pk {
    return [self findFirstByCriteria:[NSString stringWithFormat:@"id = %@", pk] orderBy:nil];
}

+ (NSArray *)findByCriteria:(NSString *)criteria orderBy:(NSString *)order {
    NSString *query = [NSString stringWithFormat:@"SELECT %@ FROM %@",
                       [[[self dataMap] allKeys] componentsJoinedByString:@", "], 
                       [self tableName]];
    if (criteria) {
        query = [NSString stringWithFormat:@"%@ WHERE %@", query, criteria];
    }
    if (order) {
        query = [NSString stringWithFormat:@"%@ ORDER BY %@", query, order];
    }
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
    return [database execute:query delegate:self rowHandler:selector];
}

+ (id) readFromRow:(DatabaseResultSet *)result {
    NSDictionary *dataMap = [self dataMap];
    NSDictionary *properties = [self propertyNamesAndTypes];
    NSArray *columnNames = [dataMap allKeys];
    id instance = [[[self alloc] init] autorelease];
    for (int i = 0; i < columnNames.count; i++) {
        NSString *property = [dataMap valueForKey:[columnNames objectAtIndex:i]];
        NSString *type = [properties valueForKey:property];
        if ([type isEqual:[NSString className]]) {
            [instance setValue:[result stringAt:i] forKey:property];
        }
        else if ([type isEqual:[NSNumber className]]) {
            [instance setValue:[result doubleAt:i] forKey:property];
        }
        else if ([type isEqual:[NSDate className]]) {
            [instance setValue:[result dateAt:i] forKey:property];
        }
    }
    return instance;
}

-(void)save {
    
}


@end
    
