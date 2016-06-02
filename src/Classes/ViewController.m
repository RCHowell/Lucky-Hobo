//
//  ViewController.m
//  Lucky Hobo
//
//  Created by R Conner Howell on 6/1/16.
//
//
@import GoogleMobileAds;
#import "ViewController.h"

@implementation ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    // CODE BREAKS AT LINE 25
    // TODO: Implement Ads
//    GADBannerView *adView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
//    NSLog(@"Created AdView");
//    adView.rootViewController = self;
//    adView.adUnitID = @"ID created when registering your app";
//    
//    // Place the ad view onto the screen.
//    [self.view addSubview:adView];
//    
//    // Request an ad without any additional targeting information.
//    [adView loadRequest:[GADRequest request]];
    
    
    [super viewDidLoad];
}


- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

@end
