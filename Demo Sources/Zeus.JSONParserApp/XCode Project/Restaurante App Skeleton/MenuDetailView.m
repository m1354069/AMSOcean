//
//  MenuDetailView.m
//  Restaurante App Skeleton
//
//  Created by Anthony on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuDetailView.h"
#import "AFImageCache.h"
#import "UIImageView+AFNetworking.h"

@implementation MenuDetailView
@synthesize itemID;
@synthesize icon, iconURL;
@synthesize itemName, itemTitle;
@synthesize description, itemDescription; 
@synthesize price, priceLbl;
@synthesize serves, servesLbl;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    icon.layer.cornerRadius = 5.0;
    icon.clipsToBounds = YES;
    icon.layer.borderColor = [[UIColor whiteColor] CGColor];
    icon.layer.borderWidth = 2.0;
    [icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",iconURL]]];
    [itemTitle setText:itemName];
    [itemDescription setText:description];
    [priceLbl setText:price];
    [servesLbl setText:serves];
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
