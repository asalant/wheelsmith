#import "PickerController.h"


@implementation PickerController

@synthesize pickerView, options, selectedOption, target, handler;

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return options.count;
}

- (NSString *) pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    id item = [options objectAtIndex:row];
    if ([item isKindOfClass:[NSNumber class]])
        return [NSString stringWithFormat:@"%@", item];
    else
        return item;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (target && handler) {
        [target performSelector:handler withObject:[options objectAtIndex:row]];
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pickerView selectRow:[options indexOfObject:selectedOption] inComponent:0 animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [options release];
    [target release];
    [super dealloc];
}


@end
