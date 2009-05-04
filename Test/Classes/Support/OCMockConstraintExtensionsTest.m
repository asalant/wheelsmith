#import "GTMSenTestCase.h"
#define HC_SHORTHAND

#import "OCMockConstraint+Extensions.h"

@interface OCMockConstraintExtensionsTest : SenTestCase {}
@end

@implementation OCMockConstraintExtensionsTest

- (void)testIsKindOfClass
{
	OCMConstraint *constraint = [OCMConstraint isKindOfClass:[NSString class]];
	STAssertTrue([constraint evaluate:@"foo"], @"Should have accepted a string.");
	STAssertFalse([constraint evaluate:[NSNumber numberWithInt:1]], @"Should not have accepted a number");
	STAssertFalse([constraint evaluate:nil], @"Should not have accepted nil.");	
}
@end
