//
//  MainNavigationTableViewController.h
//  AMSOcean
//
//  Created by Haralambos Yokos on 7/16/12.
//  Copyright (c) 2012 Descartes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainNavigationTableViewController : UITableViewController{
    UIBarButtonItem *logoutButton;

}

@property (retain, nonatomic) UIBarButtonItem *logoutButton;

- (IBAction)logoutButtonClicked:(id)sender;

@end
