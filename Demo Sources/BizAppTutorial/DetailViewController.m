//
//  DetailViewController.m
//  BizAppTutorial
//
//  Created by Tope on 06/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize titleLabel, articleWebView, articleImageView, metaLabel, nameLabel, scrollView, service;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:scrollView];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 61)];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [titleLabel setNumberOfLines:2];
    [scrollView addSubview:titleLabel];
    
    self.articleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 58, 320, 109)];
    [articleImageView setContentMode:UIViewContentModeScaleAspectFill];
    [articleImageView setClipsToBounds:YES];
    [scrollView addSubview:articleImageView];


    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 169, 170, 21)];
    [nameLabel setFont:[UIFont systemFontOfSize:13]];
    [nameLabel setText:@"By John Doe / Posted under: "];
    [scrollView addSubview:nameLabel];
    
    self.metaLabel = [[UILabel alloc] initWithFrame:CGRectMake(183, 169, 117, 21)];
    [metaLabel setFont:[UIFont systemFontOfSize:13]];
    [metaLabel setTextColor:[UIColor colorWithRed:30.0/255 green:144.0/255 blue:224.0/255 alpha:1.0]];
    [scrollView addSubview:metaLabel];
    
     
    self.articleWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 204, 300, 190)];
    [scrollView addSubview:articleWebView];
    
    
    UIView* dividerView = [[UIView alloc] initWithFrame:CGRectMake(10, 194, 300, 2)];
    [dividerView setBackgroundColor:[UIColor lightGrayColor]];
    [scrollView addSubview:dividerView];
    
    
    [titleLabel setText:service.webContentTitle];
    [articleImageView setImage:service.webContentImage];
    [articleWebView loadHTMLString:service.webContent baseURL:nil];
    [metaLabel setText:service.caption];
    
    
    
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
