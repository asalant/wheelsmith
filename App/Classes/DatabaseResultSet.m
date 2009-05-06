#import "DatabaseResultSet.h"
#import <sqlite3.h>

@implementation DatabaseResultSet

- (id) initWithPreparedStatement:(sqlite3_stmt *)ps {
    if (self = [super init]) {
        dbps = ps;
    }
    return self;
}

- (BOOL) nextRecord {
    return sqlite3_step(dbps) == SQLITE_ROW;
}

- (NSNumber *) integerAt:(int) column {
    if (sqlite3_column_text(dbps, column) == nil)
        return nil;
    
    return [NSNumber numberWithInt: sqlite3_column_int(dbps, column)];
}

- (NSNumber *) doubleAt:(int) column {
    if (sqlite3_column_text(dbps, column) == nil)
        return nil;
    
    return [NSNumber numberWithDouble: sqlite3_column_double(dbps, column)];
}

- (NSString *) stringAt:(int) column {
    if (sqlite3_column_text(dbps, column) == nil)
        return nil;
    
    return [[[NSString alloc] initWithUTF8String: (char*) sqlite3_column_text(dbps, column)] autorelease];
}

- (BOOL) booleanAt:(int) column {
    if (sqlite3_column_text(dbps, column) == nil)
        return NO;
    
    return (sqlite3_column_text(dbps, column)[0] == 't');
}


- (NSDate *) dateAt:(int) column {
    if (sqlite3_column_text(dbps, column) == nil)
        return nil;
    
    return [NSDate dateWithTimeIntervalSince1970:sqlite3_column_int(dbps, column)];
}

- (void) dealloc {
    [super dealloc];
}

@end
