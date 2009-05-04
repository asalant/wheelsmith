#import "GTMSenTestCase.h"
#define HC_SHORTHAND
#import <hamcrest/hamcrest.h>
#import <OCMock/OCMock.h>
#import "OCMockConstraint+Extensions.h"
#import "UIViewController+Testable.h"

#import "PickerController.h"
#import "Rim.h"

@interface PickerControllerTest : SenTestCase {}
PickerController *controller;
id pickerView;
NSString *selection;
@end

@implementation PickerControllerTest

-(void) setUp {
    controller = [[PickerController alloc] initWithNibName:@"PickerView" bundle:nil];
    controller.options = [NSArray arrayWithObjects:@"One", @"Two", @"Three", nil];
    
    pickerView = [OCMockObject mockForClass:[UIPickerView class]];
    controller.pickerView = pickerView;
}

-(void) tearDown {
    [pickerView verify];
}

- (void) testDisplaysSelection {
    controller.selectedOption = @"Two";
    
    [[pickerView expect] selectRow:1 inComponent:0 animated:NO];
    
    [controller viewDidLoad];
}

- (void) testCallsHandler {
    controller.target = self;
    controller.handler = @selector(handlePickerSelection:);
    
    [controller pickerView:pickerView didSelectRow:2 inComponent:0];
    assertThat(selection, equalTo(@"Three"));
}

- (void) handlePickerSelection:(NSString *)item {
        selection = item;
}
                            

@end
