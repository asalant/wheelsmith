#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>

#import "DomainObject.h"
#import "DomainObject+Persistent.h"


@interface DomainObjectTest : SenTestCase {}

@end

@implementation DomainObjectTest

-(void)testPropertySupportSetsProperties {
    NSDate *now = [NSDate date];
    DomainObject *obj = [[[DomainObject alloc] init] autorelease];
    [obj setProperties:[NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithInt:1], @"pk",
                        now, @"createdAt",
                        now, @"updatedAt",
                        nil]];
    assertThat(obj.pk, is([NSNumber numberWithInt:1]));
    assertThat(obj.createdAt, is(now));
    assertThat(obj.updatedAt, is(now));
}

-(void)testPropertySupportGetsPropertyTypes {
    NSDictionary *namesToType = [DomainObject propertyNamesAndTypes];
    assertThat([namesToType objectForKey:@"pk"], is([NSNumber className]));
    assertThat([namesToType objectForKey:@"createdAt"], is([NSDate className]));
}


@end
