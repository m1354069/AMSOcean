//
//  ZeusGETViewController.m
//  SimpleURLConnections
//
//  Created by Haralambos Yokos on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZeusGETViewController.h"

#import "NetworkManager.h"

#pragma mark * Utilities

#pragma mark * ZeusGETViewController

static NSString * kDefaultGetURLText = @"http://unpbook.com/small.gif";


@interface ZeusGETViewController () <UITextFieldDelegate>


@property (nonatomic, strong, readwrite) IBOutlet UITextField *             urlText;
@property (nonatomic, strong, readwrite) IBOutlet UIImageView *             imageView;
@property (nonatomic, strong, readwrite) IBOutlet UILabel *                 statusLabel;
@property (nonatomic, strong, readwrite) IBOutlet UIActivityIndicatorView * activityIndicator;
@property (nonatomic, strong, readwrite) IBOutlet UIButton *         getOrCancelButton;

- (IBAction)getOrCancelAction:(id)sender;

// Properties that don't need to be seen by the outside world.

@property (nonatomic, assign, readonly ) BOOL                               isReceiving;
@property (nonatomic, strong, readwrite) NSURLConnection *                  connection;
@property (nonatomic, copy,   readwrite) NSString *                         filePath;
@property (nonatomic, strong, readwrite) NSOutputStream *                   fileStream;

@end

@implementation ZeusGETViewController



@synthesize connection    = _connection;
@synthesize filePath      = _filePath;
@synthesize fileStream    = _fileStream;


@synthesize urlText           = _urlText;
@synthesize imageView         = _imageView;
@synthesize statusLabel       = _statusLabel;
@synthesize activityIndicator = _activityIndicator;
@synthesize getOrCancelButton = _getOrCancelButton;



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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark * Status management

// These methods are used by the core transfer code to update the UI.

- (void)receiveDidStart
{
    // Clear the current image so that we get a nice visual cue if the receive fails.
    self.imageView.image = [UIImage imageNamed:@"NoImage.png"];
    self.statusLabel.text = @"Receiving";
   // self.getOrCancelButton.title = @"Cancel";
    [self.activityIndicator startAnimating];
    [[NetworkManager sharedInstance] didStartNetworkOperation];
}

- (void)updateStatus:(NSString *)statusString
{
    assert(statusString != nil);
    self.statusLabel.text = statusString;
}

- (void)receiveDidStopWithStatus:(NSString *)statusString
{
    if (statusString == nil) {
        assert(self.filePath != nil);
        self.imageView.image = [UIImage imageWithContentsOfFile:self.filePath];
        statusString = @"GET succeeded";
    }
    self.statusLabel.text = statusString;
  //  self.getOrCancelButton.title = @"Get";
    [self.activityIndicator stopAnimating];
    [[NetworkManager sharedInstance] didStopNetworkOperation];
}

#pragma mark * Core transfer code

// This is the code that actually does the networking.

- (BOOL)isReceiving
{
    return (self.connection != nil);
}

- (void)startReceive
// Starts a connection to download the current URL.
{
    BOOL                success;
    NSURL *             url;
    NSURLRequest *      request;
    
    assert(self.connection == nil);         // don't tap receive twice in a row!
    assert(self.fileStream == nil);         // ditto
    assert(self.filePath == nil);           // ditto
    
    // First get and check the URL.
    
    url = [[NetworkManager sharedInstance] smartURLForString:self.urlText.text];
    success = (url != nil);
    
    // If the URL is bogus, let the user know.  Otherwise kick off the connection.
    
    if ( ! success) {
        self.statusLabel.text = @"Invalid URL";
    } else {
        
        // Open a stream for the file we're going to receive into.
        
        self.filePath = [[NetworkManager sharedInstance] pathForTemporaryFileWithPrefix:@"Get"];
        assert(self.filePath != nil);
        
        self.fileStream = [NSOutputStream outputStreamToFileAtPath:self.filePath append:NO];
        assert(self.fileStream != nil);
        
        [self.fileStream open];
        
        // Open a connection for the URL.
        
        request = [NSURLRequest requestWithURL:url];
        assert(request != nil);
        
        self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
        assert(self.connection != nil);
        
        // Tell the UI we're receiving.
        
        [self receiveDidStart];
    }
}

- (void)stopReceiveWithStatus:(NSString *)statusString
// Shuts down the connection and displays the result (statusString == nil) 
// or the error status (otherwise).
{
    if (self.connection != nil) {
        [self.connection cancel];
        self.connection = nil;
    }
    if (self.fileStream != nil) {
        [self.fileStream close];
        self.fileStream = nil;
    }
    [self receiveDidStopWithStatus:statusString];
    self.filePath = nil;
}

- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response
// A delegate method called by the NSURLConnection when the request/response 
// exchange is complete.  We look at the response to check that the HTTP 
// status code is 2xx and that the Content-Type is acceptable.  If these checks 
// fail, we give up on the transfer.
{
#pragma unused(theConnection)
    NSHTTPURLResponse * httpResponse;
    NSString *          contentTypeHeader;
    
    assert(theConnection == self.connection);
    
    httpResponse = (NSHTTPURLResponse *) response;
    assert( [httpResponse isKindOfClass:[NSHTTPURLResponse class]] );
    
    if ((httpResponse.statusCode / 100) != 2) {
        [self stopReceiveWithStatus:[NSString stringWithFormat:@"HTTP error %zd", (ssize_t) httpResponse.statusCode]];
    } else {
        // -MIMEType strips any parameters, strips leading or trailer whitespace, and lower cases 
        // the string, so we can just use -isEqual: on the result.
        contentTypeHeader = [httpResponse MIMEType];
        if (contentTypeHeader == nil) {
            [self stopReceiveWithStatus:@"No Content-Type!"];
        } else if ( ! [contentTypeHeader isEqual:@"image/jpeg"] 
                   && ! [contentTypeHeader isEqual:@"image/png"] 
                   && ! [contentTypeHeader isEqual:@"image/gif"] ) {
            [self stopReceiveWithStatus:[NSString stringWithFormat:@"Unsupported Content-Type (%@)", contentTypeHeader]];
        } else {
            self.statusLabel.text = @"Response OK.";
        }
    }    
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data
// A delegate method called by the NSURLConnection as data arrives.  We just 
// write the data to the file.
{
#pragma unused(theConnection)
    NSInteger       dataLength;
    const uint8_t * dataBytes;
    NSInteger       bytesWritten;
    NSInteger       bytesWrittenSoFar;
    
    assert(theConnection == self.connection);
    
    dataLength = [data length];
    dataBytes  = [data bytes];
    
    bytesWrittenSoFar = 0;
    do {
        bytesWritten = [self.fileStream write:&dataBytes[bytesWrittenSoFar] maxLength:dataLength - bytesWrittenSoFar];
        assert(bytesWritten != 0);
        if (bytesWritten == -1) {
            [self stopReceiveWithStatus:@"File write error"];
            break;
        } else {
            bytesWrittenSoFar += bytesWritten;
        }
    } while (bytesWrittenSoFar != dataLength);
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
// A delegate method called by the NSURLConnection if the connection fails. 
// We shut down the connection and display the failure.  Production quality code 
// would either display or log the actual error.
{
#pragma unused(theConnection)
#pragma unused(error)
    assert(theConnection == self.connection);
    
    [self stopReceiveWithStatus:@"Connection failed"];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
// A delegate method called by the NSURLConnection when the connection has been 
// done successfully.  We shut down the connection with a nil status, which 
// causes the image to be displayed.
{
#pragma unused(theConnection)
    assert(theConnection == self.connection);
    
    [self stopReceiveWithStatus:nil];
}

#pragma mark * UI Actions

- (IBAction)getOrCancelAction:(id)sender
{
#pragma unused(sender)
    if (self.isReceiving) {
        [self stopReceiveWithStatus:@"Cancelled"];
    } else {
        [self startReceive];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
// A delegate method called by the URL text field when the editing is complete. 
// We save the current value of the field in our settings.
{
#pragma unused(textField)
    NSString *  newValue;
    NSString *  oldValue;
    
    assert(textField == self.urlText);
    
    newValue = self.urlText.text;
    oldValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"GetURLText"];
    
    // Save the URL text if there is no pre-existing setting and it's not our 
    // default value, or if there is a pre-existing default and the new value 
    // is different.
    
    if (   ((oldValue == nil) && ! [newValue isEqual:kDefaultGetURLText] ) 
        || ((oldValue != nil) && ! [newValue isEqual:oldValue] ) ) {
        [[NSUserDefaults standardUserDefaults] setObject:newValue forKey:@"GetURLText"];
    }    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
// A delegate method called by the URL text field when the user taps the Return 
// key.  We just dismiss the keyboard.
{
#pragma unused(textField)
    assert(textField == self.urlText);
    [self.urlText resignFirstResponder];
    return NO;
}

@end
