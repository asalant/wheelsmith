#import "RimDetailController.h"
#import "StringUtil.h"

@implementation RimDetailController

@synthesize rim;
@synthesize brandLabel, descriptionLabel, erdLabel, offsetLabel, sizeLabel, holeCountLabel;
@synthesize editWheelDelegate, editController;

-(void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
//                                                                                            target:self 
//                                                                                            action:@selector(editRim)] autorelease];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    brandLabel.text = rim.brand;
    descriptionLabel.text = rim.description;
    erdLabel.text = [StringUtil formatFloat:rim.erd];
    offsetLabel.text = [StringUtil formatFloat:rim.offset];
    sizeLabel.text = [rim.size description];
    holeCountLabel.text = [NSString stringWithFormat:@"%d holes", [rim.holeCount intValue]];
}

-(IBAction)chooseRim {
    [self.editWheelDelegate setRim:rim];
}

-(void)editRim {
    editController.rim = rim;
    [self.navigationController pushViewController:editController animated:YES];
}

- (void)dealloc {
    [rim release];
    [editController release];
    [super dealloc];
}


@end

