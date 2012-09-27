//
//  iSeeiAct
//
//  Created by sugartin.info on 08/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
#import "REST.h"
#import "JSONParser.h"


@implementation REST




-(void)Get_StoreDetails:(SEL)seletor andHandler:(NSObject *)handler andCountryId:(NSString *)country_id{
    NSDictionary *req = [NSDictionary dictionaryWithObjectsAndKeys:@"content/get_stores",@"request",
						 [NSDictionary dictionaryWithObjectsAndKeys:USERNAME,@"username",
						  PASSWORD,@"password",
						  country_id,@"country_id",
						  nil],@"para",nil];	
	[[[JSONParser alloc] initWithRequest:req sel:seletor andHandler:handler] autorelease];
    
}
    

@end
