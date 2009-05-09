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

-(IBAction)saveRim {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [rim release];
    [super dealloc];
}


@end

