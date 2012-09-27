//
//  iSeeiAct
//
//  Created by sugartin.info on 08/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "LocalSettings.h"


@implementation LocalSettings

@synthesize phone,is_authenticated,is_request_sent,success,isDirty;

-(LocalSettings*)initWithSettings{
	self = [super init];
	if(self){
		[self getFileSettings];
		self.isDirty = NO;
		return self;
	}
	return self;
}

-(void)copyFileIfNotExists{
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"user_status.plist"];

	success = [fileManager fileExistsAtPath:filePath];
	if (success) return;
	
	NSError *error;
	NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/user_status.plist"];
	success = [fileManager copyItemAtPath:path toPath:filePath error:&error];
	
	if (!success) {
		NSAssert1(0, @"Failed to copy Plist. Error %@", [error localizedDescription]);
	}
}

-(void)getFileSettings{
	[self copyFileIfNotExists];
	if (success) {
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"user_status.plist"];
		
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
		phone = [dict objectForKey:@"phone"];
		is_authenticated  = (NSInteger)[dict objectForKey:@"is_authenticated"];
		is_request_sent = (NSInteger)[dict objectForKey:@"is_request_sent"];
	}
}

-(NSInteger)is_Authenticated{
	return is_authenticated;
}
-(NSInteger)is_RequestSent{
	return is_request_sent;
}
-(NSString*)Phone{
	return phone;
}
-(void)setPhone:(NSString *)no{
	isDirty = YES;
	phone = no;
}
-(void)setIs_request_sent:(NSInteger)no{
	isDirty = YES;
	is_request_sent = no;
}
-(void)setIs_authenticated:(NSInteger)no{
	isDirty = YES;
	is_authenticated = no;
}

-(void)Save{
	if (isDirty) {
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"user_status.plist"];
		
		NSLog(@"Save Process");
		
		NSDictionary *req = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone",
																	is_request_sent,@"is_request_sent",
																	is_authenticated,@"is_authenticated",nil];
		
		[req writeToFile:filePath atomically:YES];
	}
}
	
- (void)dealloc {
	[phone dealloc];
    [super dealloc];
}
@end
