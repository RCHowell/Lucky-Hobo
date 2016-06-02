//
//  AppDelegate.m
//  AppScaffold
//

#import "AppDelegate.h"
#import "Director.h"
#import "ViewController.h"

// --- c functions ---

void onUncaughtException(NSException *exception)
{
    NSLog(@"uncaught exception: %@", exception.description);
}

// ---

@implementation AppDelegate
{
    ViewController *_viewController;
    UIWindow *_window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSSetUncaughtExceptionHandler(&onUncaughtException);
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    _window = [[UIWindow alloc] initWithFrame:screenBounds];
    _viewController = [[ViewController alloc] init];
    
    // Initialize And Load Ads
//    _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
//    _bannerView.adUnitID = @"ca-app-pub-2625988365536802/3780602977";
//    [_bannerView loadRequest:[GADRequest request]];
    

    
//    
//    self.bannerView.adUnitID = @"ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx";
//    _bannerView.rootViewController = _viewController;
//    _bannerView.delegate=(id<GADBannerViewDelegate>)self;
//    GADRequest *request = [GADRequest request];
//    // Enable test ads on simulators.
//    request.testDevices = @[kGADSimulatorID];
//    [_bannerView loadRequest:request];
    
    // Enable some common settings here:
    //
    //_viewController.showStats = YES;
     _viewController.multitouchEnabled = NO;
     _viewController.preferredFramesPerSecond = 30;
    
    [_viewController startWithRoot:[Director class] supportHighResolutions:YES doubleOnPad:YES];
    [_window setRootViewController:_viewController];
    [_window makeKeyAndVisible];
    return YES;
}

@end
