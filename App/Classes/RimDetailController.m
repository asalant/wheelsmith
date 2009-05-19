#import "RimDetailController.h"
#import "StringUtil.h"

@implementation RimDetailController

@synthesize rim;
@synthesize brandLabel, descriptionLabel, erdLabel, offsetLabel, sizeLabel, holeCountLabel;
@synthesize editWheelDelegate, editController, canChoosePart;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (canChoosePart)
    {
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                                target:self 
                                                                                                action:@selector(chooseRim)] autorelease];
    }
    else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
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

