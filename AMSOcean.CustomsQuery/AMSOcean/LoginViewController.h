//
//  LoginViewController.h
//  AMSOcean
//
//  Created by Haralambos Yokos on 7/6/12.
//  Copyright (c) 2012 Descartes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController <MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
    long long expectedLength;
	long long currentLength;
    
    NSString * username;
    NSString * password;
    UITextField * usernameField;
    UITextField * passwordField;
    UIView *loginView;
    
}

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, weak) IBOutlet UITextField *usernameField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;

@property (nonatomic, retain) IBOutlet UIView *loginView;

- (IBAction)submitButton:(id)sender;

- (void)showWithLabelMixed:(id)sender;
- (void)showURL:(id)sender;

- (void)myTask;
- (void)myProgressTask;
- (void)myMixedTask;


@end
