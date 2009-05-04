#import "UIViewController+Testable.h"

@implementation UIViewController (Testable)

-(UINavigationController *)navigationController {
    return (UINavigationController *)_parentViewController;
}

-(void)setNavigationController:(UINavigationController *)controller {
    _parentViewController = controller;
}

@end
