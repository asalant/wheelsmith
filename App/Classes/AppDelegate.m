#import "AppDelegate.h"
#import "RootMenuController.h"
#import "RimBrandListController.h"
#import "RimListController.h"
#import "RimDetailController.h"
#import "HubBrandListController.h"
#import "HubListController.h"
#import "Rim.h"
#import "Hub.h"
#import "Wheel.h"

@implementation AppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[DomainObject setDbName:@"parts"];
    
    // Create and set dependencies
    RimDetailController *rimDetailController = [[[RimDetailController alloc] initWithNibName:@"RimDetailView" bundle:nil] autorelease];
    RimListController *rimListController = [[[RimListController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    rimListController.rimDetailController = rimDetailController;
    
    RimBrandListController *rimBrandListController = [[[RimBrandListController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    rimBrandListController.rimListController = rimListController;
    
    HubDetailController *hubDetailController = [[[HubDetailController alloc] initWithNibName:@"HubDetailView" bundle:nil] autorelease];
    HubListController *hubListController =  [[[HubListController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    hubListController.hubDetailController = hubDetailController;
    
    HubBrandListController *hubBrandListController = [[[HubBrandListController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    hubBrandListController.hubListController = hubListController;
    
    WheelDetailController *wheelDetailController = [[[WheelDetailController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    wheelDetailController.rimDetailController = rimDetailController;
    wheelDetailController.hubDetailController = hubDetailController;
    
    MyWheelsController *myWheelsController = [[[MyWheelsController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    myWheelsController.wheels = [Wheel findAll];
    myWheelsController.wheelDetailController = wheelDetailController;
    
    RootMenuController *menuController = [[[RootMenuController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    menuController.title = @"Spoke Length Calculator";
    menuController.myWheelsController = myWheelsController;
    menuController.rimBrandListController = rimBrandListController;
    menuController.hubBrandListController = hubBrandListController;
    
    
    [self.navigationController pushViewController:menuController animated:NO];
    
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
