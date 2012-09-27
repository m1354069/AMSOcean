//
//  iSeeiAct
//
//  Created by sugartin.info on 08/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import <Foundation/Foundation.h>


@interface LocalSettings : NSObject {
	BOOL success;
	NSString *phone;
	NSInteger is_authenticated;
	NSInteger is_request_sent;
	BOOL isDirty;
}

@property (nonatomic,retain) NSString *phone;
@property (nonatomic,readwrite) NSInteger is_authenticated;
@property (nonatomic,readwrite) NSInteger is_request_sent;
@property (nonatomic) BOOL success;
@property (nonatomic) BOOL isDirty;

-(LocalSettings*)initWithSettings;

-(void)copyFileIfNotExists;
-(void)getFileSettings;
-(NSInteger)is_Authenticated;
-(NSInteger)is_RequestSent;
-(NSString*)Phone;
-(void)setPhone:(NSString *)no;
-(void)setIs_request_sent:(NSInteger)no;
-(void)setIs_authenticated:(NSInteger)no;
-(void)Save;
@end