//
//  FirstViewController.h
//  BizAppTutorial
//
//  Created by Tope on 02/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXLabel.h"

@interface FirstViewController : UIViewController

@property (nonatomic, strong)  FXLabel* logoLabel;

@property (nonatomic, strong)  UILabel* descriptionLabel;

@property (nonatomic, strong)  UIButton* callUsButton;

@property (nonatomic, strong)  UIButton* directionsButton;

@property (nonatomic, strong)  UILabel* copyrightLabel;

-(UILabel*)createLabelWithFrame:(CGRect)frame andFontSize:(float)fontSize andText:(NSString*)text;


-(UIButton*)createButtonWithFrame:(CGRect)frame andLabel:(NSString*)label;


-(void)callNumber;
-(void)openMap;




@end
