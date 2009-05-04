#import "RimDetailController.h"
#import "StringUtil.h"

@implementation RimDetailController

@synthesize rim;
@synthesize brandLabel, descriptionLabel, erdLabel, offsetLabel, isoLabel, sizeLabel, notesTextView, verifiedLabel;
@synthesize editWheelDelegate;


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    brandLabel.text = rim.brand;
    descriptionLabel.text = rim.description;
    erdLabel.text = [StringUtil formatFloat:rim.erd];
    offsetLabel.text = [StringUtil formatFloat:rim.offset];
    sizeLabel.text = [rim.size description];
}

-(IBAction)chooseRim {
    [self.editWheelDelegate setRim:rim];
}

- (void)dealloc {
    [rim release];
    [super dealloc];
}


@end

