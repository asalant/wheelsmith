#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>

#import "Database.h"
#import "DatabaseResultSet.h"

@interface DatabaseTest : SenTestCase {
    Database *db;
}

@end

@implementation DatabaseTest

- (void) setUp {
    db = [Database create:@"test" overwrite:YES];
}

- (void) testFailsIfDatabaseNotFound {
    @try {
        [Database create:@"foo" overwrite:YES];;
        STFail(@"Should have thrown PersistenceException");
    }
    @catch (NSException *exception) {
        assertThat([exception name], equalTo(@"PersistenceException"));
    }
}

- (void) testExecuteCallsSelector {
    NSArray *companies = [db execute:@"select distinct rims.brand from rims order by brand" delegate:self rowHandler:@selector(handleBrandRow:)];
    assertThat([NSNumber numberWithInt:[companies count]], equalTo([NSNumber numberWithInt:2]));
    assertThat([companies objectAtIndex:0], equalTo(@"Mavic"));
}

- (NSString *) handleBrandRow:(DatabaseResultSet *)result {
    return [result stringAt:0];
}

-(void) testRetrievesRailsDate {
    NSArray *dates = [db execute:@"select created_at from wheels" delegate:self rowHandler:@selector(handleDateRow:)];
    NSDate *date = [dates objectAtIndex:0];
    assertThat(date, instanceOf([NSDate class]));
    assertThat([date description], is(@"2009-05-19 07:54:57 -0700"));
}

-(void) testSavesAndRetrievesDate {
    NSDate *now = [NSDate date];
    [db execute:[NSString stringWithFormat:@"insert into wheels (id, created_at) values (100, '%@')", now] delegate:nil rowHandler:nil];
    NSArray *dates = [db execute:@"select created_at from wheels where id = 100" delegate:self rowHandler:@selector(handleDateRow:)];
    NSDate *date = [dates objectAtIndex:0];
    assertThat([date description], is([now description]));
}

-(NSDate *)handleDateRow:(DatabaseResultSet *)result {
    return [result dateAt:0];
}

@end
