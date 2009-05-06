#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseResultSet : NSObject {
    sqlite3_stmt *dbps; // database prepared statement
}

- (id) initWithPreparedStatement:(sqlite3_stmt *)dbps;
- (BOOL) nextRecord;

- (NSNumber *) integerAt:(int) column;
- (NSNumber *) doubleAt:(int) column;
- (NSString *) stringAt:(int) column;
- (BOOL) booleanAt:(int) column;
- (NSDate *) dateAt:(int) column;

@end
