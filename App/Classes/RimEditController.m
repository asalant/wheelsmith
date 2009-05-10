#import "RimEditController.h"
#import "StringUtil.h"

@implementation RimEditController

@synthesize rim;
@synthesize brandTextField, descriptionTextField, erdTextField, offsetTextField, sizeTextField, holeCountTextField;

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                            target:self 
                                                                                            action:@selector(saveRim)] autorelease];
    
    textFields = [[NSArray arrayWithObjects:brandTextField, descriptionTextField, sizeTextField, holeCountTextField,
              erdTextField, offsetTextField, nil] retain];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    brandTextField.text = rim.brand;
    descriptionTextField.text = rim.description;
    erdTextField.text = [StringUtil formatFloat:rim.erd];
    offsetTextField.text = [StringUtil formatFloat:rim.offset];
    sizeTextField.text = [rim.size description];
    holeCountTextField.text = [rim.holeCount description];
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

-(IBAction)saveRim {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [rim release];
    [textFields release];
    [super dealloc];
}


@end

