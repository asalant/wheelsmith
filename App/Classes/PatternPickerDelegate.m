#import "PatternPickerDelegate.h"


@implementation PatternPickerDelegate

@synthesize editWheelDelegate;

- (id)init {
    if (self = [super init]) {
        NSArray *patternValues = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], nil];
        NSArray *patternLabels = [NSArray arrayWithObjects: @"radial", @"1 cross", @"2 cross", @"3 cross", @"4 cross", nil];
        options = [[NSDictionary dictionaryWithObjects:patternLabels forKeys:patternValues] retain];
    }
    return self;
}


-(NSString *)labelForOption:(id)option {
    return [options objectForKey:option];
}

-(void)optionSelected:(id)option {
    [editWheelDelegate setSpokePattern:option];
}

- (void)dealloc {
    [super dealloc];
}


@end
