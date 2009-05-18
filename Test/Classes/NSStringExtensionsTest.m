#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import "NSString+Extensions.h"

@interface StringExtensionsTest : SenTestCase
@end

@implementation StringExtensionsTest

-(void)testNilIsEmpty {
    NSString *str = nil;
    assertThat([NSNumber numberWithInt:[str notEmpty]], is([NSNumber numberWithInt:0]));
}

-(void)testCharsAreNotEmpty {
    assertThat([NSNumber numberWithInt:[@"foo" notEmpty]], is([NSNumber numberWithInt:1]));
    assertThat([NSNumber numberWithInt:[@" foo  \n" notEmpty]], is([NSNumber numberWithInt:1]));
}

-(void)testWhitespaceIsEmpty {
    assertThat([NSNumber numberWithInt:[@"  " notEmpty]], is([NSNumber numberWithInt:0]));
    assertThat([NSNumber numberWithInt:[@"\n" notEmpty]], is([NSNumber numberWithInt:0]));
    assertThat([NSNumber numberWithInt:[@"  \n" notEmpty]], is([NSNumber numberWithInt:0]));
}


@end
