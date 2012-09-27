//
//  JsonDemoAppAppDelegate.h
//  JsonDemoApp
//
//  Created by sugartin.info on 19/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JsonDemoAppViewController;

@interface JsonDemoAppAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet JsonDemoAppViewController *viewController;

@end
