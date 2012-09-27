//
//  ShipmentTabsViewController.m
//  AMSOcean
//
//  Created by Haralambos Yokos on 7/3/12.
//  Copyright (c) 2012 Descartes. All rights reserved.
//

#import "ShipmentTabsViewController.h"

@interface ShipmentTabsViewController ()

@end

@implementation ShipmentTabsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait || 
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
            interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown
            );
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {

        if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
            if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
                toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
                [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"BlackTopBar.png"] forBarMetrics:UIBarMetricsDefault];
            }
            else {
                [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabBar.png"] forBarMetrics:UIBarMetricsDefault];
            }
        }
    }
    else {
        if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
            toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            // do something
        }
        else {
            // do something
        }
        
    }
}



@end
