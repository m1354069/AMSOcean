//
//  CustomPresentedViewController.m

#import "CustomPresentedViewController.h"

@implementation CustomPresentedViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"US Customs";
}

- (IBAction)done:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
