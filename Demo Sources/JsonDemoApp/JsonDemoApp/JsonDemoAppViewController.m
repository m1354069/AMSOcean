//
//  JsonDemoAppViewController.m
//  JsonDemoApp
//
//  Created by sugartin.info on 19/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JsonDemoAppViewController.h"
#import "REST.h"
@implementation JsonDemoAppViewController
@synthesize arrForStores=_arrForStores;
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    self.arrForStores=nil;
    //============================Json Initialization===================================================
	REST *rest = [[REST alloc] init];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [rest Get_StoreDetails:@selector(getData:) andHandler:self andCountryId:@"12"];
    
	alertCtr = [[[UIAlertView alloc] initWithTitle:@"\nPlease Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] autorelease];
	[alertCtr show];
	
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	
	// Adjust the indicator so it is up a few pixels from the bottom of the alert
	indicator.center = CGPointMake(alertCtr.bounds.size.width / 2, alertCtr.bounds.size.height - 50);
	[indicator startAnimating];
	[alertCtr addSubview:indicator];
	[indicator release];
	//===================================================================================================

}
//============================Json with parsing===================================================
- (void)getData:(id)object{
    NSLog(@"%@",object);
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Controll comes here..");
        //IF your response type is NSDictionary then this code to run
	}
	
	
    if ([object isKindOfClass:[NSArray class]])
    {
        self.arrForStores=[NSArray arrayWithArray:(NSArray*)object]; 
        //IF your response type is NSArray then this code to run
    }

	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[alertCtr dismissWithClickedButtonIndex:0 animated:YES];
	
    
}
//==================================================================================================

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
