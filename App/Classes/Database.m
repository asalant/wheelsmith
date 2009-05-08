#import <sqlite3.h>

#import "Database.h"
#import "DatabaseResultSet.h"

@implementation Database

+(Database *)create:(NSString *)name overwrite:(BOOL)overwrite {
    NSString *documentFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbFilePath = [documentFilePath stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.sqlite3", name]];
    [dbFilePath retain];  
    
    // Remove existing database in Documents if it exists and we are overwriting
    if ([[NSFileManager defaultManager] fileExistsAtPath: dbFilePath]) {
        if (overwrite) {
            NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
            if (! [[NSFileManager defaultManager] removeItemAtPath:dbFilePath error:&error]) { 
                @throw [NSException exceptionWithName:@"PersistenceException"
                                               reason:[NSString stringWithFormat:@"Failed to remove database %@: %@", dbFilePath, error]
                                             userInfo:nil];
            }
            NSLog(@"%@: Overwriting existing database at %@", [self class], dbFilePath);
        }
        else {
            NSLog(@"%@: Using existing database at %@", [self class], dbFilePath);
        }
    }
    else {
        NSLog(@"%@: Creating new database at %@", [self class], dbFilePath);
    }
    
    // Copy source database if there is not one in Documents
    if (![[NSFileManager defaultManager] fileExistsAtPath: dbFilePath]) {
        NSString *sourceDbFilePath = [[NSBundle mainBundle] pathForResource:name ofType:@"sqlite3"];
        if (sourceDbFilePath == NULL) {
            @throw [NSException exceptionWithName:@"PersistenceException"
                                           reason:[NSString stringWithFormat:@"Source database %@ does not exist", name]
                                         userInfo:nil];
        }
        NSError *error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
        if (! [[NSFileManager defaultManager] copyItemAtPath:sourceDbFilePath toPath:dbFilePath error:&error]) { 
            @throw [NSException exceptionWithName:@"PersistenceException"
                                           reason:[NSString stringWithFormat:@"Failed to copy database %@ to %@: %@", sourceDbFilePath, dbFilePath, error]
                                         userInfo:nil];
        }
    }
    return [[[Database alloc] initWithName:dbFilePath] autorelease];
}

- (id) initWithName:(NSString *)filePath {
    
    if (self = [super init]) {
        dbFilePath = filePath;
        [dbFilePath retain];  
        NSLog(@"%@: initialized for database at %@", [self class], dbFilePath); 
    }
    return self;
}

- (NSArray *) execute:(NSString *)query delegate:(id)delegate rowHandler:(SEL)selector {
    sqlite3 *db;
    int dbrc; // database return code
    dbrc = sqlite3_open ([dbFilePath UTF8String], &db);
    if (dbrc) {
        @throw [NSException exceptionWithName:@"PersistenceException"
                                       reason:[NSString stringWithFormat:@"Could not open database %@", dbFilePath]
                                     userInfo:nil];
    }
    
    // select stuff
    sqlite3_stmt *dbps; // database prepared statement
    const char *queryStatement = [query UTF8String];
    NSLog(@"%@.select: Executing %@", [self class], query);
    dbrc = sqlite3_prepare_v2 (db, queryStatement, -1, &dbps, NULL);
    
    if (dbrc) {
        @throw [NSException exceptionWithName:@"PersistenceException"
                                       reason:[NSString stringWithFormat:@"Error[code %d] executing \"%@\"", dbrc, query]
                                     userInfo:nil];
    }
    
    NSMutableArray *items = [[[NSMutableArray alloc] initWithCapacity: 100] autorelease]; // arbitrary capacity
    
    DatabaseResultSet *resultSet = [[DatabaseResultSet alloc] initWithPreparedStatement:dbps];
    while ([resultSet nextRecord]) {
        // Call back to the delegate
        id item = [delegate performSelector:selector withObject:resultSet];
        [items addObject:item];
    }
    
    // done with the db.  finalize the statement and close
    sqlite3_finalize (dbps);
    sqlite3_close(db);
    [resultSet release];
    
    return items;
}

- (void) dealloc {
    [dbFilePath release];
    [super dealloc];
}

@end
