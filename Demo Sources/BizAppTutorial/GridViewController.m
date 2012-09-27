//
//  GridViewController.m
//  BizAppTutorial
//
//  Created by Tope on 03/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GridViewController.h"
#import "GridViewCell.h"
#import "BusinessService.h"
#import "DetailViewController.h"

#import <QuartzCore/QuartzCore.h>

@implementation GridViewController


@synthesize gridView, services;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	self.gridView.autoresizesSubviews = YES;
	self.gridView.delegate = self;
	self.gridView.dataSource = self;
    
    [self.view addSubview:gridView];
    
    UIImage * backgroundPattern = [UIImage imageNamed:@"bg-app.png"];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];
    
    self.services = [BusinessService getSampleData];
    
    [self.gridView reloadData];
    
    UIView* gradientView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 4)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gradientView.bounds;
    
    UIColor* lightColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    UIColor* darkColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    gradient.colors = [NSArray arrayWithObjects:(id)darkColor.CGColor, (id)lightColor.CGColor, nil];
    [gradientView.layer insertSublayer:gradient atIndex:0];

    [self.view addSubview:gradientView];
    
}


- (NSUInteger) numberOfItemsInGridView: (AQGridView *) aGridView
{
    return [services count];
}


- (AQGridViewCell *) gridView: (AQGridView *) aGridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * PlainCellIdentifier = @"PlainCellIdentifier";
    
    
    GridViewCell * cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:@"PlainCellIdentifier"];
    
    if ( cell == nil )
    {
        cell = [[GridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 160, 123)
                                   reuseIdentifier: PlainCellIdentifier];

    }
    
    BusinessService* service = [services objectAtIndex:index];
    
    [cell.imageView setImage:service.image];
    [cell.captionLabel setText:service.caption];
    
    return cell;
    
}


- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) aGridView
{
    return ( CGSizeMake(160.0, 123) );
}

-(void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index
{
    [self performSegueWithIdentifier:@"detail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController* detail = segue.destinationViewController;
    
    BusinessService* service = [services objectAtIndex:[gridView indexOfSelectedItem]];
    
    detail.service = service;
}

@end
