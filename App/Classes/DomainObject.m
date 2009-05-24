#import "DomainObject.h"
#import "Database.h"
#import "SqliteDateFormatter.h"

static Database *database;

@implementation DomainObject

@synthesize pk, createdAt, updatedAt;

+ (void) setDatabase:(Database *)theDatabase {
    database = [theDatabase retain];
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
    NSMutableDictionary *dataMap = [NSMutableDictionary dictionaryWithDictionary:[[self class] dataMap]];
    [dataMap removeObjectForKey:@"id"];
    NSArray *values = [self propertyValuesForColumns:[dataMap allKeys]];
    NSString *insert = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",
                        [[self class] tableName],
                        [[dataMap allKeys] componentsJoinedByString:@", "],
                        [values componentsJoinedByString:@", "]];
    [database execute:insert delegate:nil rowHandler:nil];
    
    id created = [[self class] findFirstByCriteria:[NSString stringWithFormat:@"created_at = '%@'", 
                                                    [[SqliteDateFormatter sharedFormatter] stringFromDate:self.createdAt]]
                                           orderBy:nil];
    self.pk = [created valueForKey:@"pk"];
}

-(void) update {
    self.updatedAt = [NSDate date];
    NSMutableDictionary *dataMap = [NSMutableDictionary dictionaryWithDictionary:[[self class] dataMap]];
    [dataMap removeObjectForKey:@"id"];
    NSArray *columnNames = [dataMap allKeys];
    NSArray *values = [self propertyValuesForColumns:columnNames];
    NSMutableArray *updates = [NSMutableArray array];
    for (int i = 0; i < columnNames.count; i++) {
        [updates addObject:[NSString stringWithFormat:@"%@=%@", [columnNames objectAtIndex:i], [values objectAtIndex:i]]];
    }
    NSString *update = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE id = %d",
                        [[self class] tableName],
                        [updates componentsJoinedByString:@", "],
                        [self.pk intValue]];
    [database execute:update delegate:nil rowHandler:nil];
}

-(void)save {
    if (self.pk) {
        [self update];
    }
    else {
        [self create];
    }
}

-(void)delete {
    NSString *delete = [NSString stringWithFormat:@"DELETE FROM %@ WHERE id = %d",
                        [[self class] tableName],
                        [self.pk intValue]];
    [database execute:delete delegate:nil rowHandler:nil];
}

-(NSArray *)propertyValuesForColumns:(NSArray *)columnNames {
    
    NSMutableArray *values = [NSMutableArray array];
    NSDictionary *dataMap = [[self class] dataMap];
    for (id columnName in columnNames) {
        id value = [self valueForKey:[[dataMap valueForKey:columnName] objectAtIndex:0]];
        NSString *type = [[dataMap valueForKey:columnName] objectAtIndex:1];
        if (!value) {
            [values addObject:@"NULL"];
        }
        else if ([type isEqual:@"string"]) {
            [values addObject:[NSString stringWithFormat:@"'%@'", value]];
        }
        else if ([type isEqual:@"integer"]) {
            [values addObject:[NSString stringWithFormat:@"%d", [value intValue]]];
        }
        else if ([type isEqual:@"float"]) {
            [values addObject:[NSString stringWithFormat:@"%f", [value doubleValue]]];
        }
        else if ([type isEqual:@"datetime"]) {
            [values addObject:[NSString stringWithFormat:@"'%@'", [[SqliteDateFormatter sharedFormatter] stringFromDate:value]]];
        }
        else if ([type isEqual:@"boolean"]) {
            [values addObject:[value boolValue] ? @"'t'" : @"'f'"];
        }
    }
    return values;
}

-(void)revert {
    if (!self.pk)
        return;
 
    DomainObject *saved = [[self class] find:self.pk];
    NSDictionary *dataMap = [[self class] dataMap];
    for (id definition in [dataMap allValues]) {
        NSString *propertyName = [definition objectAtIndex:0];
        [self setValue:[saved valueForKey:propertyName] forKey:propertyName];
    }
}

-(void)dealloc {
    [pk release];
    [createdAt release];
    [updatedAt release];
    [super dealloc];
}
@end

