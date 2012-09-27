//
//  DetailViewController.h
//  BizAppTutorial
//
//  Created by Tope on 06/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessService.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *articleImageView;

@property (nonatomic, strong) UILabel* metaLabel;

@property (nonatomic, strong) UILabel* nameLabel;

@property (nonatomic, strong) UIWebView* articleWebView;

@property (nonatomic, strong) UIScrollView* scrollView;

@property (nonatomic, retain) BusinessService* service;

@end
