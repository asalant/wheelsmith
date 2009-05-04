#import "OCMockConstraint+Extensions.h"

@interface OCMKindOfClassConstraint : OCMConstraint
{
    @public
    id testClass;
}
@end

@implementation OCMKindOfClassConstraint

- (BOOL)evaluate:(id)value
{
	return [value isKindOfClass:testClass];
}

@end

@implementation OCMConstraint (Extensions)

+ (id)isKindOfClass:(id)value {
	OCMKindOfClassConstraint *constraint = [OCMKindOfClassConstraint constraint];
	constraint->testClass = value;
	return constraint;
}

@end
