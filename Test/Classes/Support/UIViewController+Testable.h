// Modifies property accessibility in UIViewController so that members such as navigationController can be mocked.
#import <UIKit/UIKit.h>

@interface UIViewController (Testable)

// Override readonly property in UIViewController
@property(nonatomic, retain) UINavigationController *navigationController;

@end
