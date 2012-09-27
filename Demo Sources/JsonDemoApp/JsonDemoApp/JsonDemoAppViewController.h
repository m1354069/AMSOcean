//
//  JsonDemoAppViewController.h
//  JsonDemoApp
//
//  Created by sugartin.info on 19/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JsonDemoAppViewController : UIViewController{
	UIAlertView *alertCtr;
}



@property(nonatomic,retain)NSMutableArray *arrForStores;
- (void)getData:(id)object;
@end
