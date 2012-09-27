//
//  AppDelegate.m
//  Restaurante App Skeleton
//
//  Created by Anthony on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "DrinksViewController.h"
#import "DessertViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize rootController = _rootController;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    MenuViewController *menu = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    UINavigationController *menuNav = [[UINavigationController alloc] initWithRootViewController:menu];
    menu.title = @"Shipments";
    
    DrinksViewController *drinks = [[DrinksViewController alloc] initWithNibName:@"DrinksViewController" bundle:nil];
    UINavigationController *drinksNav = [[UINavigationController alloc] initWithRootViewController:drinks];
    drinks.title = @"Purchase Orders";
    
    DessertViewController *dessert = [[DessertViewController alloc] initWithNibName:@"DessertViewController" bundle:nil];
    UINavigationController *dessertNav = [[UINavigationController alloc] initWithRootViewController:dessert];
    dessert.title = @"Shipping Orders";
    
    //Uncomment the following four lines for black navigation bars
    menuNav.navigationBar.tintColor = [UIColor blackColor];
    drinksNav.navigationBar.tintColor = [UIColor blackColor];
    dessertNav.navigationBar.tintColor = [UIColor blackColor];
    
    //Initialize the tabBarController
    self.rootController = [[[UITabBarController alloc] init] autorelease];
    
    //Add the items to the tabBarController
    self.rootController.viewControllers = [NSArray arrayWithObjects: menuNav, drinksNav, dessertNav, nil];
    
    //Set the names of the tabs
    [[self.rootController.tabBar.items objectAtIndex:0] setTitle:@"Shipments"];
    [[self.rootController.tabBar.items objectAtIndex:1] setTitle:@"PO"];
    [[self.rootController.tabBar.items objectAtIndex:2] setTitle:@"SO"];
    
    //Set the icons of the tabs
    [[self.rootController.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"globe.png"]];
    [[self.rootController.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"moniter.png"]];
    [[self.rootController.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"truck.png"]];
    
    //Release memory
    [menu release];
    [menuNav release];
    [drinks release];
    [drinksNav release];
    [dessert release];
    [dessertNav release];
    
    //Add the tabBarController to the main window
    self.window.rootViewController = self.rootController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
