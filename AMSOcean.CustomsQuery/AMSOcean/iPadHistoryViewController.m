//
//  iPadHistoryViewController.m
//  AMSOcean
//
//  Created by Haralambos Yokos on 7/20/12.
//  Copyright (c) 2012 Descartes. All rights reserved.
//

#import "iPadHistoryViewController.h"

@interface iPadHistoryViewController ()

@end

@implementation iPadHistoryViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
/**
- (IBAction)showPopoverFromBarButtonItem:(id)sender {	
	// Set the sender to a UIBarButtonItem.
	UIBarButtonItem *tappedButton = (UIBarButtonItem *)sender;
	
	// If the master list popover is showing, dismiss it before presenting the popover from the bar button item.
	if (mainPopoverController != nil) {
        [mainPopoverController dismissPopoverAnimated:YES];
    } 
	
	// If the popover is already showing from the bar button item, dismiss it. Otherwise, present it.
	if (barButtonItemPopover.popoverVisible == NO) {
		[barButtonItemPopover presentPopoverFromBarButtonItem:tappedButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];		
	}
	else {
		[barButtonItemPopover dismissPopoverAnimated:YES];
	}
}
 */
@end
