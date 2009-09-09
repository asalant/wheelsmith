#import <Foundation/Foundation.h>
#import "Wheel.h"

@interface WheelEmail : NSObject {
    Wheel *wheel;
}

@property(nonatomic, retain) Wheel *wheel;

+(WheelEmail *) emailForWheel:(Wheel *)wheel;

-(NSString *) formatBody;
-(NSString *) formatSubject;
-(NSString *) createMailToUrl;

@end
