//
//  HelpViewController.h
//  AMSOcean
//
//  Created by Haralambos Yokos on 7/5/12.
//  Copyright (c) 2012 Descartes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController {
    UINavigationBar *navbar;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navbar;

- (IBAction)done:(id)sender;

@end
