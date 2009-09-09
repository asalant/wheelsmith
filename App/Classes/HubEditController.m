#import "HubEditController.h"
#import "StringUtil.h"
#import "NSString+Extensions.h"
#import "FlurryAPI.h"

@implementation HubEditController

@synthesize hub, detailController;
@synthesize brandTextField, descriptionTextField, holeCountTextField, rearSwitch;
@synthesize leftFlangeDiameterTextField, leftFlangeToCenterTextField, rightFlangeDiameterTextField, rightFlangeToCenterTextField;

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                            target:self 
                                                                                            action:@selector(saveHub)] autorelease];
    
    textFields = [[NSArray arrayWithObjects:brandTextField, descriptionTextField, holeCountTextField, 
              leftFlangeDiameterTextField, leftFlangeToCenterTextField, rightFlangeDiameterTextField, rightFlangeToCenterTextField, nil] retain];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    brandTextField.text = hub.brand;
    descriptionTextField.text = hub.description;
    rearSwitch.on = hub.rear ? [hub.rear boolValue] : NO;
    holeCountTextField.text = [hub.holeCount description];
    leftFlangeDiameterTextField.text = [StringUtil formatFloat:hub.leftFlangeDiameter];
    leftFlangeToCenterTextField.text = [StringUtil formatFloat:hub.leftFlangeToCenter];
    rightFlangeDiameterTextField.text = [StringUtil formatFloat:hub.rightFlangeDiameter];
    rightFlangeToCenterTextField.text = [StringUtil formatFloat:hub.rightFlangeToCenter];
}

-(void)viewWillDisappear:(BOOL)animated {
    [currentInput resignFirstResponder];
}

#pragma mark UITextFieldDelegate methods 

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    int index = [textFields indexOfObject:textField];
    [[textFields objectAtIndex:(index + 1) % textFields.count] becomeFirstResponder];
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    currentInput = textField;
}

-(IBAction)saveHub {
    hub.brand = brandTextField.text;
    hub.description = descriptionTextField.text;
    hub.holeCount = [holeCountTextField.text intValue] == 0 ? nil : [NSNumber numberWithInt:[holeCountTextField.text intValue]];
    hub.rear = [NSNumber numberWithBool:rearSwitch.on];
    hub.leftFlangeDiameter = [leftFlangeDiameterTextField.text doubleValue] == 0.0 ? nil : [NSNumber numberWithDouble:[leftFlangeDiameterTextField.text doubleValue]];
    hub.leftFlangeToCenter = [leftFlangeToCenterTextField.text doubleValue] == 0.0 ? nil : [NSNumber numberWithDouble:[leftFlangeToCenterTextField.text doubleValue]];
    hub.rightFlangeDiameter = [rightFlangeDiameterTextField.text doubleValue] == 0.0 ? nil : [NSNumber numberWithDouble:[rightFlangeDiameterTextField.text doubleValue]];
    hub.rightFlangeToCenter = [rightFlangeToCenterTextField.text doubleValue] == 0.0 ? nil : [NSNumber numberWithDouble:[rightFlangeToCenterTextField.text doubleValue]];
    if (hub.pk) {
        [hub update];
        [FlurryAPI logEvent:@"Update Hub" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          hub.brand,  @"brand", 
                                                          hub.description, @"description",
                                                          nil]];
    }
    else {
        [hub create];
        [FlurryAPI logEvent:@"Create Hub" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          hub.brand,  @"brand", 
                                                          hub.description, @"description",
                                                          nil]];
    }
    
    [detailController.editWheelDelegate setHub:hub];
}

- (void)dealloc {
    [hub release];
    [detailController release];
    [textFields release];
    [super dealloc];
}


@end

