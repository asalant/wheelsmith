#import "DomainObject+Persistent.h"
#import "Database.h"
#import "DatabaseResultSet.h"
#import "Hub.h"

static Database *database;

@implementation DomainObject (Persistent)

+ (void) setDbName:(NSString *)name {
    database = [[Database alloc] initWithName:name];
}

+ (NSDictionary *) dataMap {
    NSDictionary *namesToType = [self propertyNamesAndTypes];
    NSMutableDictionary *dataMap = [NSMutableDictionary dictionary];
    for (id name in [namesToType allKeys]) {
        if ([name isEqual:@"pk"])
            [dataMap setValue:[NSArray arrayWithObjects:@"pk", @"NSNumber", nil] 
                       forKey:@"id"];
        else
            [dataMap setValue:[NSArray arrayWithObjects:name, [namesToType valueForKey:name], nil] 
                       forKey:[name underscore]];
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
    NSArray *columnNames = [dataMap allKeys];
    id instance = [[[self alloc] init] autorelease];
    for (int i = 0; i < columnNames.count; i++) {
        NSString *columnName = [columnNames objectAtIndex:i];
        NSString *property = [[dataMap valueForKey:columnName] objectAtIndex:0];
        NSString *type = [[dataMap valueForKey:columnName] objectAtIndex:1];
        //NSString *type = [properties valueForKey:property];
        if ([type isEqual:[NSString className]]) {
            [instance setValue:[result stringAt:i] forKey:property];
        }
        else if ([type isEqual:[NSNumber className]]) {
            [instance setValue:[result doubleAt:i] forKey:property];
        }
        else if ([type isEqual:[NSDate className]]) {
            [instance setValue:[result dateAt:i] forKey:property];
        }
        else if ([type isEqual:@"BOOL"]) {
            [instance setValue:[NSNumber numberWithBool:[result booleanAt:i]] forKey:property];
        }
    }
    return instance;
}

-(void)save {
    
}


@end
    
