//
//  iSeeiAct
//
//  Created by sugartin.info on 08/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import <Foundation/Foundation.h>
#import "JSON.h"

@interface REST : NSObject {
	NSMutableData *responseData;
	NSURL *theUrl;	
}


-(void)Get_StoreDetails:(SEL)seletor andHandler:(NSObject*)handler andCountryId:(NSString *)CountryCode;

@end
