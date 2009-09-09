#import "AppDelegate.h"
#import "FlurryAPI.h"
#import "MyWheelsController.h"
#import "RimBrandsController.h"
#import "RimListController.h"
#import "RimDetailController.h"
#import "RimEditController.h"
#import "HubEditController.h"
#import "HubDetailController.h"
#import "HubBrandsController.h"
#import "HubListController.h"
#import "Rim.h"
#import "Hub.h"
#import "Wheel.h"

@implementation AppDelegate

@synthesize window;
@synthesize navigationController;

void uncaughtExceptionHandler(NSException *exception) {
    [FlurryAPI logError:@"Uncaught exception" message:@"Application crash" exception:exception];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {

    // Analytics configuration
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [FlurryAPI startSession:@"3QX4VNFUP7F4FPVDAG5Q"];
    
	[DomainObject setDatabase:[Database create:@"parts" overwrite:NO]];
    
    // Create and set dependencies
    RimDetailController *rimDetailController = [[[RimDetailController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    rimDetailController.title = @"Rim Detail";
    
    RimEditController *rimEditController= [[[RimEditController alloc] initWithNibName:@"RimEditView" bundle:nil] autorelease];
    rimEditController.title = @"Add Rim";
    rimEditController.detailController = rimDetailController;
    
    RimListController *rimListController = [[[RimListController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    rimListController.rimDetailController = rimDetailController;
    rimListController.editController = rimEditController;
    
    RimBrandsController *rimBrandsController = [[[RimBrandsController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    rimBrandsController.title = @"Rim Brands";
    rimBrandsController.brands = [Rim selectBrandNames];
    rimBrandsController.rimsController = rimListController;
    rimBrandsController.editController = rimEditController;    
    
    HubDetailController *hubDetailController = [[[HubDetailController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    hubDetailController.title = @"Hub Detail";
    
    HubEditController *hubEditController= [[[HubEditController alloc] initWithNibName:@"HubEditView" bundle:nil] autorelease];
    hubEditController.title = @"Add Hub";
    hubEditController.detailController = hubDetailController;
    
    HubListController *hubListController =  [[[HubListController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    hubListController.hubDetailController = hubDetailController;
    hubListController.editController = hubEditController;
    
    HubBrandsController *hubBrandsController = [[[HubBrandsController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    hubBrandsController.title = @"Hub Brands";
    hubBrandsController.brands = [Hub selectBrandNames];
    hubBrandsController.hubsController = hubListController;
    hubBrandsController.editController = hubEditController;
    
    WheelDetailController *wheelDetailController = [[[WheelDetailController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    wheelDetailController.title = @"Wheel Build";
    wheelDetailController.rimDetailController = rimDetailController;
    wheelDetailController.hubDetailController = hubDetailController;
    wheelDetailController.rimBrandsController = rimBrandsController;
    wheelDetailController.hubBrandsController = hubBrandsController;
    
    // Would like to use the same instance as above but there are nav bar rendering issues when switching between existing and new wheels
    WheelDetailController *newWheelDetailController = [[[WheelDetailController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    newWheelDetailController.title = @"New Wheel Build";
    newWheelDetailController.rimDetailController = rimDetailController;
    newWheelDetailController.hubDetailController = hubDetailController;
    newWheelDetailController.rimBrandsController = rimBrandsController;
    newWheelDetailController.hubBrandsController = hubBrandsController;
    
    UINavigationController *newWheelController = [[[UINavigationController alloc] initWithRootViewController:newWheelDetailController] autorelease];
    
    MyWheelsController *myWheelsController = [[[MyWheelsController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    myWheelsController.title = @"My Wheels";
    myWheelsController.wheels = [NSMutableArray arrayWithArray:[Wheel findAllOrderBy:@"created_at desc"]];
    myWheelsController.wheelDetailController = wheelDetailController;
    myWheelsController.newWheelController = newWheelController;
    newWheelDetailController.delegate = myWheelsController;
    wheelDetailController.delegate = myWheelsController;
    
    [self.navigationController pushViewController:myWheelsController animated:NO];
    
	// Configure the window
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
	[window addSubview:[navigationController view]];
    
    // Show new wheel modal if no existing wheels
    if (myWheelsController.wheels.count == 0) {
        newWheelDetailController.wheel = [[[Wheel alloc] init] autorelease];
        newWheelDetailController.editing = YES;
        [myWheelsController presentModalViewController:newWheelController animated:NO];
    }
    
	// Show the window
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
