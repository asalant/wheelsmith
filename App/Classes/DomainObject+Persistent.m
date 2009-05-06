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
    @throw [NSException exceptionWithName:@"PersistenceException"
                                   reason:[NSString stringWithFormat:@"Implement +dataMap in %@ to define OR mapping.", [self class]]
                                 userInfo:nil];
                                                        
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
        if ([type isEqual:@"string"]) {
            [instance setValue:[result stringAt:i] forKey:property];
        }
        else if ([type isEqual:@"integer"]) {
            [instance setValue:[result integerAt:i] forKey:property];
        }
        else if ([type isEqual:@"float"]) {
            [instance setValue:[result doubleAt:i] forKey:property];
        }
        else if ([type isEqual:@"datetime"]) {
            [instance setValue:[result dateAt:i] forKey:property];
        }
        else if ([type isEqual:@"boolean"]) {
            [instance setValue:[NSNumber numberWithBool:[result booleanAt:i]] forKey:property];
        }
    }
    return instance;
}

-(void)create {
    self.createdAt = [NSDate date];
    self.updatedAt = self.createdAt;
    NSDictionary *dataMap = [[self class] dataMap];
    NSMutableArray *values = [NSMutableArray array];
    for (id columnName in dataMap) {
        id value = [self valueForKey:[[dataMap valueForKey:columnName] objectAtIndex:0]];
        NSString *type = [[dataMap valueForKey:columnName] objectAtIndex:1];
        if (!value) {
            [values addObject:@"NULL"];
        }
        else if ([type isEqual:@"string"]) {

        }
        else if ([type isEqual:@"integer"]) {
            [values addObject:[NSString stringWithFormat:@"%d", [value intValue]]];
        }
        else if ([type isEqual:@"float"]) {
            [values addObject:[NSString stringWithFormat:@"%f", [value doubleValue]]];
        }
        else if ([type isEqual:@"datetime"]) {
            [values addObject:[NSString stringWithFormat:@"'%@'", value]];
        }
        else if ([type isEqual:@"boolean"]) {
            [values addObject:[NSString stringWithFormat:@"%@", [value boolValue]]];
        }
    }
    NSString *insert = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",
                        [[self class] tableName],
                        [[dataMap allKeys] componentsJoinedByString:@", "],
                        [values componentsJoinedByString:@", "]];
    [database execute:insert delegate:nil rowHandler:nil];
    
    id created = [[self class] findFirstByCriteria:[NSString stringWithFormat:@"created_at = '%@'", self.createdAt]
                                           orderBy:nil];
    self.pk = [created valueForKey:@"pk"];
}


@end
    
