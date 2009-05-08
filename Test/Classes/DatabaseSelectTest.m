#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>

#import "Database.h"
#import "DatabaseResultSet.h"

@interface DatabaseSelectTest : SenTestCase {
    Database *db;
}

@end

@implementation DatabaseSelectTest

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

- (void) testSelectCallsSelector {
    NSArray *companies = [db execute:@"select distinct rims.brand from rims order by brand" delegate:self rowHandler:@selector(handleBrandRow:)];
    assertThat([NSNumber numberWithInt:[companies count]], equalTo([NSNumber numberWithInt:2]));
    assertThat([companies objectAtIndex:0], equalTo(@"Mavic"));
}

- (NSString *) handleBrandRow:(DatabaseResultSet *)result {
    return [result stringAt:0];
}

@end
