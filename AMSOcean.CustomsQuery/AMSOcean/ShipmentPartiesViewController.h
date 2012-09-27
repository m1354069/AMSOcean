//
//  ShipmentPartiesViewController.h
//  AMSOcean
//
//  Created by Haralambos Yokos on 7/3/12.
//  Copyright (c) 2012 Descartes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShipmentPartiesViewController : UIViewController {
       UINavigationBar *navBar;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;

- (IBAction)done:(id)sender;


@end
