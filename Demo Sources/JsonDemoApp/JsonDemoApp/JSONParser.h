//
//  iSeeiAct
//
//  Created by sugartin.info on 08/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import <Foundation/Foundation.h>


@interface JSONParser : NSObject {
	NSURLConnection *con;
	NSMutableData *myWebData;
	SEL targetSelector;
	NSObject *MainHandler;
}
-(id)initWithRequest:(NSDictionary*)object sel:(SEL)seletor andHandler:(NSObject*)handler;
@end
