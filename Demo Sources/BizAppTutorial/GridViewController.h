//
//  GridViewController.h
//  BizAppTutorial
//
//  Created by Tope on 03/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridView.h"

@interface GridViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource>


@property (nonatomic, retain) IBOutlet AQGridView * gridView;

@property (nonatomic, retain) NSArray * services;


@end
