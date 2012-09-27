//
//  MenuDetailView.h
//  Restaurante App Skeleton
//
//  Created by Anthony on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MenuDetailView : UIViewController {
    NSString *itemID;
    
    UIImageView *icon;
    NSString *iconURL;
    
    NSString *itemName;
    UILabel *itemTitle;
    
    NSString *description;
    UITextView *itemDescription;
    
    NSString *price;
    UILabel *priceLbl;
    
    NSString *serves;
    UILabel *servesLbl;
}
@property (nonatomic, copy) NSString *itemID;
@property (nonatomic, retain) IBOutlet UIImageView *icon;
@property (nonatomic, copy) NSString *iconURL;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, retain) IBOutlet UILabel *itemTitle;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, retain) IBOutlet UITextView *itemDescription;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, retain) IBOutlet UILabel *priceLbl;
@property (nonatomic, copy) NSString *serves;
@property (nonatomic, retain) IBOutlet UILabel *servesLbl;
@end