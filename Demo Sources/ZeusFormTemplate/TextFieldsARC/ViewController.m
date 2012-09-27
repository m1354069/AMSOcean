//
//  ViewController.m
//  TextFieldsARC
//
//  Created by Aaron Crabtree on 5/29/12.
//  Copyright (c) 2012 Tap Dezign, LLC. All rights reserved.
//

/*--
 
 THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTY OF ANY KIND, 
 EXPRESS OR IMPLIED,INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS 
 OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN 
 AN ACTION OF CONTRACT,TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH 
 THE USE OF THIS CODE OR ANY OTHER DEALINGS RELATING TO THIS SOFTWARE.
 
 --*/

#import "ViewController.h"
@implementation ViewController

#pragma mark -
#pragma mark UIViewController Override Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*--
     * Create the Password textField programmatically
     * Set the look and functionality of the textField
     * set the Delegate to self - more specifically the ViewController object that conforms to the <UITextFieldDelegate> Protocol 
     * Set the UITextField's tag to 2 so that we can identify it later
     --*/
    
    CGRect passwordTextFieldFrame = CGRectMake(20.0f, 100.0f, 280.0f, 31.0f);
    UITextField *passwordTextField = [[UITextField alloc] initWithFrame:passwordTextFieldFrame];
    passwordTextField.placeholder = @"Password";
    passwordTextField.backgroundColor = [UIColor whiteColor];
    passwordTextField.textColor = [UIColor blackColor];
    passwordTextField.font = [UIFont systemFontOfSize:14.0f];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.textAlignment = UITextAlignmentLeft;
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordTextField.tag = 2;
    passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordTextField.delegate = self;
    [self.view addSubview:passwordTextField];
    
}

#pragma mark -
#pragma mark UIViewController Rotation Methods
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark UITextFieldDelegate Protocol Methods 
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    /*--
     * This method is called just before the textField becomes active 
     * Return YES to let the textField become the First Responder otherwise return NO
     * Use this method to give the textField a gray colored background
     --*/
    
    NSLog(@"textFieldShouldBeginEditing");
    textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{           
    /*--
     * This method is called when the textField becomes active, or is the First Responder
     --*/
    
    NSLog(@"textFieldDidBeginEditing");
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    /*--
     * This method is called just before the textField is no longer active
     * Return YES to let the textField resign first responder status, otherwise return NO
     * Use this method to turn the background color back to white
     --*/
    
    NSLog(@"textFieldShouldEndEditing");
    
    textField.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    /*--
     * This method is called when the textField is no longer active
     --*/
    
    NSLog(@"textFieldDidEndEditing");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*--
     * This method is called just before text in the textField is displayed
     * This is a good place to disallow certain characters
     * Return YES to update the textField otherwise return NO
     --*/
    NSLog(@"textField:shouldChangeCharactersInRange:replacementString:");
    
    if ([string isEqualToString:@"#"]) {
        return NO;
    }
    else {
        return YES;
    }
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    //Called when clear button is pressed. Return YES to clear the active textField otherwise return NO
    NSLog(@"textFieldShouldClear:");
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    /*--
     * This Delegate method is called when the user taps the return key
     * It asks the textField if it is the Username textField by checking its tag number
     * If the textField is Username, it changes the active textField to the Password textField
     * viewWithTag returns any subview from the ViewController's view property that has a matching tag 
     * if the active textField is not Username, it just resigns the first responder status from the Password textField and hides the keypad
     --*/
    
    NSLog(@"textFieldShouldReturn:");
    
    if (textField.tag == 1) {
        // The active textField is Username, so move to password
        UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:2];
        [passwordTextField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark -
#pragma mark UIResponder Override
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /*--
     * Override UIResponder touchesBegan:withEvent: to resign any active textFields when the user taps the background
     * Use fast enumeration to go through the subview property of UIView
     * Any object that is the current first repsonder will resign that status
     * Make a call to super to take care of any unknown behavior that touchesBegan:withEvent: needs to do behind the scenes
     --*/
    
    NSLog(@"touchesBegan:withEvent:");
    
    for (UITextField *textField in self.view.subviews) {
        if ([textField isFirstResponder]) {
            [textField resignFirstResponder];
        }
    }
    [super touchesBegan:touches withEvent:event];
}

@end
