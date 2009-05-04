#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>
#import "OCMockConstraint+Extensions.h"
#import "UIViewController+Testable.h"

#import "HubDetailController.h"
#import "Hub.h"

@interface HubDetailControllerTest : SenTestCase {}
    HubDetailController *controller;
@end

@implementation HubDetailControllerTest

-(void) setUp {
    controller = [[HubDetailController alloc] initWithNibName:@"HubDetailView" bundle:nil];
    controller.brandLabel = [[UILabel alloc] init];
    controller.descriptionLabel  = [[UILabel alloc] init];    controller.verifiedLabel  = [[UILabel alloc] init];
    controller.notesTextView = [[UITextView alloc] init];
}

@end
