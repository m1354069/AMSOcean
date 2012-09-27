//
//  ShipmentPartiesViewController.m
//  AMSOcean
//
//  Created by Haralambos Yokos on 7/3/12.
//  Copyright (c) 2012 Descartes. All rights reserved.
//

#import "ShipmentPartiesViewController.h"

@interface ShipmentPartiesViewController ()

@end


@implementation ShipmentPartiesViewController
@synthesize navBar;

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
 
    if ([self.navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        NSLog(@"If statement reached");
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            NSLog(@"My Code thinks we are on an ipad");
            [self.navBar setBackgroundImage:[UIImage imageNamed:@"SleekNavigationBar.png"] forBarMetrics:UIBarMetricsDefault];
        }
        else {
            NSLog(@"My Code thinks we are on an iphone");
            [self.navBar setBackgroundImage:[UIImage imageNamed:@"TopNavBar.png"] forBarMetrics:UIBarMetricsDefault];
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)done:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
