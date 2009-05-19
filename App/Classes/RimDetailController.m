#import "RimDetailController.h"
#import "StringUtil.h"

@implementation RimDetailController

@synthesize rim;
@synthesize brandLabel, descriptionLabel, erdLabel, offsetLabel, sizeLabel, holeCountLabel, deleteButton;
@synthesize editWheelDelegate, canChoosePart;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (canChoosePart)
    {
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
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
    deleteButton.hidden = [rim.verified boolValue];
}

-(IBAction)chooseRim {
    [self.editWheelDelegate setRim:rim];
}

-(IBAction)deleteRim {
    [rim delete];
    [self.editWheelDelegate setRim:nil];
}

- (void)dealloc {
    [rim release];
    [super dealloc];
}


@end

