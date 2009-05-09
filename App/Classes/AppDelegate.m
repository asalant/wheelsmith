#import "AppDelegate.h"
#import "RootMenuController.h"
#import "RimBrandsController.h"
#import "RimListController.h"
#import "RimDetailController.h"
#import "HubBrandsController.h"
#import "HubListController.h"
#import "Rim.h"
#import "Hub.h"
#import "Wheel.h"

@implementation AppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[DomainObject setDatabase:[Database create:@"parts" overwrite:NO]];
    
    // Create and set dependencies
    RimDetailController *rimDetailController = [[[RimDetailController alloc] initWithNibName:@"RimDetailView" bundle:nil] autorelease];
    RimListController *rimListController = [[[RimListController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    rimListController.rimDetailController = rimDetailController;
    
    RimBrandsController *rimBrandsController = [[[RimBrandsController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    rimBrandsController.title = @"Rim Brands";
    rimBrandsController.brands = [Rim selectBrandNames];
    rimBrandsController.rimsController = rimListController;
    
    HubDetailController *hubDetailController = [[[HubDetailController alloc] initWithNibName:@"HubDetailView" bundle:nil] autorelease];
    HubListController *hubListController =  [[[HubListController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    hubListController.hubDetailController = hubDetailController;
    
    HubBrandsController *hubBrandsController = [[[HubBrandsController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    hubBrandsController.title = @"Hub Brands";
    hubBrandsController.brands = [Hub selectBrandNames];
    hubBrandsController.hubsController = hubListController;
    
    WheelDetailController *wheelDetailController = [[[WheelDetailController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    wheelDetailController.rimDetailController = rimDetailController;
    wheelDetailController.hubDetailController = hubDetailController;
    wheelDetailController.rimBrandsController = rimBrandsController;
    wheelDetailController.hubBrandsController = hubBrandsController;
    
    // Would like to use the same instance as above but there are nav bar rendering issues when switching between existing and new wheels
    WheelDetailController *newWheelDetailController = [[[WheelDetailController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    newWheelDetailController.rimDetailController = rimDetailController;
    newWheelDetailController.hubDetailController = hubDetailController;
    newWheelDetailController.rimBrandsController = rimBrandsController;
    newWheelDetailController.hubBrandsController = hubBrandsController;
    
    UINavigationController *newWheelController = [[[UINavigationController alloc] initWithRootViewController:newWheelDetailController] autorelease];
    
    MyWheelsController *myWheelsController = [[[MyWheelsController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    myWheelsController.wheels = [NSMutableArray arrayWithArray:[Wheel findAllOrderBy:@"created_at desc"]];
    myWheelsController.wheelDetailController = wheelDetailController;
    myWheelsController.newWheelController = newWheelController;
    newWheelDetailController.delegate = myWheelsController;
    wheelDetailController.delegate = myWheelsController;
    
    RootMenuController *menuController = [[[RootMenuController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    menuController.title = @"Spoke Length Calculator";
    menuController.myWheelsController = myWheelsController;
    menuController.rimBrandListController = rimBrandsController;
    menuController.hubBrandListController = hubBrandsController;
    
    
    [self.navigationController pushViewController:myWheelsController animated:NO];
    
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
