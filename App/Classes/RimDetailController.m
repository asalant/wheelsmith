#import "RimDetailController.h"
#import "StringUtil.h"

@implementation RimDetailController

@synthesize rim;
@synthesize brandLabel, descriptionLabel, erdLabel, offsetLabel, isoLabel, sizeLabel, notesTextView, verifiedLabel;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    brandLabel.text = rim.brand;
    descriptionLabel.text = rim.description;
    erdLabel.text = [StringUtil formatFloat:rim.erd];
    offsetLabel.text = [StringUtil formatFloat:rim.offset];
    sizeLabel.text = [rim.size description];
}

- (void)dealloc {
    [rim release];
    [super dealloc];
}


@end

