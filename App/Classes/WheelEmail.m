#import "WheelEmail.h"


@implementation WheelEmail

@synthesize wheel;

+(WheelEmail *) emailForWheel:(Wheel *)wheel {
    WheelEmail *email = [[[WheelEmail alloc] init] autorelease];
    email.wheel = wheel;
    return email;
}

-(NSString *) formatSubject {
    return [NSString stringWithFormat:@"Wheel Build: %@ Hub w/ %@ Rim, %@", wheel.hub.brand, wheel.rim.brand, wheel.spokePatternDescription];
}

-(NSString *) formatBody {
    return [NSString stringWithFormat:@"<html><body><style>td { vertical-align:top; }</style><table>"
            "<tr><td><b>Hub</b>:</td><td>%@ %@</td></tr>"
            "<tr><td><b>Rim</b>:</td><td>%@ %@</td></tr>"
            "<tr><td><b>Pattern:<b/></td><td>%@</td></tr>"
            "</table><p/><table>"
            "<tr><td><b>Left Spoke:<b/></td><td>%@ mm</td></tr>"
            "<tr><td><b>Right Spoke:<b/></td><td>%@ mm</td></tr>"
            "</table></body></html>", 
            wheel.hub.brand, wheel.hub.description, 
            wheel.rim.brand, wheel.rim.description,
            wheel.spokePatternDescription,
            wheel.leftSpokeLength, wheel.rightSpokeLength];
}

-(NSString *) createMailToUrl {
    return [NSString stringWithFormat:@"mailto:?subject=%@&body=%@",
            [[self formatSubject] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
            [[self formatBody] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];;
}

-(void)dealloc {
    [wheel release];
    [super dealloc];
}

@end
