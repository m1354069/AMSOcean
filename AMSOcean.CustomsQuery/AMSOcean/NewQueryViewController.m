//
//  NewQueryViewController.m
//  AMSOcean
//
//  Created by Haralambos Yokos on 7/6/12.
//  Copyright (c) 2012 Descartes. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "RequestQueue.h"
#import "NewQueryViewController.h"
#import <unistd.h>

@interface NewQueryViewController ()

@property (nonatomic, strong) NSURLAuthenticationChallenge *challenge;

@end

@implementation NewQueryViewController

@synthesize issuerScac;
@synthesize billNumber;
@synthesize submitQueryButton;
@synthesize clearButton;
@synthesize challenge;


#pragma mark -
#pragma mark View Methods

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (IBAction)showWithLabelMixed:(id)sender {
	
	HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = @"Connecting";
	HUD.minSize = CGSizeMake(135.f, 135.f);
	
	[HUD showWhileExecuting:@selector(myMixedTask) onTarget:self withObject:nil animated:YES];
}

- (IBAction)showURL:(id)sender {
	NSURL *URL = [NSURL URLWithString:@"https://github.com/matej/MBProgressHUD/zipball/master"];
	NSURLRequest *request = [NSURLRequest requestWithURL:URL];
	
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	[connection start];
	[connection release];
	
	HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
}



-(IBAction)newQueryButtonPushed:(id)sender{
    //NSString *scac = issuerScac.text.uppercaseString;
    //NSLog(@"Scac Value is");
    //NSLog(scac);
    
    [self executeNewQuery];
   // [self runNewQuery];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}


#pragma mark -
#pragma mark Request Que Functions

- (void)executeNewQuery{
    NSLog(@"Query About to execute");
    
    NSString *post = @"key1=val1&key2=val2";
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];

    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:@"http://www.nowhere.com/sendFormHere.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSLog(@"QUERY EXECUTED VIA POST");
}

-(void)runNewQuery{
    //set up request for protected resource
    NSURL *URL = [NSURL URLWithString:@"http://www.charcoaldesign.co.uk/RequestQueue/Auth/IMG_0351.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RQOperation *operation = [RQOperation operationWithRequest:request];

    //add auth handler
    operation.authenticationChallengeHandler = ^(NSURLAuthenticationChallenge *_challenge)
    {
        challenge = _challenge;
        [[[UIAlertView alloc] initWithTitle:@"Challenge Receiver" message:@"Send credentials?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil] show];
    
    };

    //add response handler
    operation.completionHandler = ^(NSURLResponse *response, NSData *data, NSError *error)
    {
        if (error)
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
        else
        {
            //set image
           // imageView.image = [UIImage imageWithData:data];
            [self ShowAlert:@"Run New Query" MyMsg:@"Completion Handler"];
        }
    };

    //make request
    [[RequestQueue mainQueue] addOperation:operation];
}


- (void) ShowAlert:(NSString*)title MyMsg:(NSString*)msg {
	UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert autorelease];
}


#pragma mark -
#pragma mark HUD Execution code

- (void)myTask {
	// Do something usefull in here instead of sleeping ...
	sleep(3);
}

- (void)myProgressTask {
	// This just increases the progress indicator in a loop
	float progress = 0.0f;
	while (progress < 1.0f) {
		progress += 0.01f;
		HUD.progress = progress;
		usleep(50000);
	}
}

- (void)myMixedTask {
	// Indeterminate mode
	sleep(2);
	// Switch to determinate mode
	HUD.mode = MBProgressHUDModeDeterminate;
	HUD.labelText = @"Searching for Bill";
	float progress = 0.0f;
	while (progress < 1.0f)
	{
		progress += 0.01f;
		HUD.progress = progress;
		usleep(50000);
	}
	// Back to indeterminate mode
	HUD.mode = MBProgressHUDModeIndeterminate;
	HUD.labelText = @"Recieving Data";
	sleep(2);
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Select.png"]] autorelease];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = @"Processed";
	sleep(2);
}

#pragma mark -
#pragma mark HUD NSURLConnectionDelegete

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	expectedLength = [response expectedContentLength];
	currentLength = 0;
	HUD.mode = MBProgressHUDModeDeterminate;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	currentLength += [data length];
	HUD.progress = currentLength / (float)expectedLength;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	HUD.mode = MBProgressHUDModeCustomView;
	[HUD hide:YES afterDelay:2];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[HUD hide:YES];
}

#pragma mark -
#pragma mark HUD MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}

/**
-(void)openConnection{
    // Create the request.
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com/"]
                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                      timeoutInterval:60.0];
    // create the connection with the request
    // and start loading the data
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        receivedData = [[NSMutableData data] retain];
    } else {
        // Inform the user that the connection failed.
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}
*/

@end
