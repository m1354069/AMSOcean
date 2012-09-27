//
//  NewQueryViewController.h
//  AMSOcean
//
//  Created by Haralambos Yokos on 7/6/12.
//  Copyright (c) 2012 Descartes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface NewQueryViewController : UIViewController <MBProgressHUDDelegate>{
	MBProgressHUD *HUD;
    long long expectedLength;
	long long currentLength;
    
    UITextField *issuerScac;
    UITextField *billNumber;
    UIButton *submitQueryButton;
    UIBarButtonItem *clearButton;
}

@property (nonatomic, weak) IBOutlet UITextField *issuerScac;
@property (nonatomic, weak) IBOutlet UITextField *billNumber;
@property (nonatomic, weak) IBOutlet UIButton *submitQueryButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *clearButton;

-(IBAction)newQueryButtonPushed:(id)sender;

- (void)executeNewQuery;

- (IBAction)showWithLabelMixed:(id)sender;
- (IBAction)showURL:(id)sender;

- (void)myTask;
- (void)myProgressTask;
- (void)myMixedTask;


@end
