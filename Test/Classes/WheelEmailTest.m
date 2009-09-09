#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>

#import "Database.h"
#import "DomainObject.h"
#import "Wheel.h"
#import "WheelEmail.h"

@interface WheelEmailTest : SenTestCase {}

@end

@implementation WheelEmailTest

-(void) setUp {
	[DomainObject setDatabase:[Database create:@"test" overwrite:YES]];
}

-(void)testCreatesEmail {
    Wheel *wheel = [Wheel findFirstByCriteria:@"spoke_pattern = 0" orderBy:nil];
    WheelEmail *email = [WheelEmail emailForWheel:wheel];
    
    assertThat(email, notNilValue());
    assertThat(email.wheel, is(wheel));
}

-(void)testFormatsSubject {
    Wheel *wheel = [Wheel findFirstByCriteria:@"spoke_pattern = 0" orderBy:nil];
    WheelEmail *email = [WheelEmail emailForWheel:wheel];
    
    assertThat([email formatSubject], is(@"Wheel Build: Campagnolo Hub w/ Mavic Rim, radial"));
}

-(void)testFormatsBody {
    Wheel *wheel = [Wheel findFirstByCriteria:@"spoke_pattern = 0" orderBy:nil];
    WheelEmail *email = [WheelEmail emailForWheel:wheel];
    
    assertThat([email formatBody], startsWith(@"<html><body>"));
}

-(void)testCreatesMailToUrl {
    Wheel *wheel = [Wheel findFirstByCriteria:@"spoke_pattern = 0" orderBy:nil];
    WheelEmail *email = [WheelEmail emailForWheel:wheel];
    
    assertThat([email createMailToUrl], startsWith(@"mailto:?subject=Wheel%20Build:%20Campagnolo%20Hub%20w/%20Mavic%20Rim,%20radial"));
}
    

@end
