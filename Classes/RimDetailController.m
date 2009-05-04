#import "RimDetailController.h"
#import "StringUtil.h"

@implementation RimDetailController

@synthesize rim;
@synthesize brandLabel, descriptionLabel, erdLabel, offsetLabel, isoLabel, sizeLabel, notesTextView, verifiedLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    brandLabel.text = rim.brand;
    descriptionLabel.text = rim.description;
    erdLabel.text = [StringUtil formatFloat:rim.erd];
    offsetLabel.text = [StringUtil formatFloat:rim.offset];
    sizeLabel.text = [rim.size description];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
    [rim release];
    [super dealloc];
}


@end

