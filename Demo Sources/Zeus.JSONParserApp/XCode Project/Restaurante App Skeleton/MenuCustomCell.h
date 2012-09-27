//
//  MenuCustomCell.h
//  Restaurante App Skeleton
//
//  Created by Anthony on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MenuCustomCell : UITableViewCell {
    UILabel *title;
    UILabel *price;
    UILabel *serves;
    UIImageView *thumb;
    UIView *bg;
}
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *price;
@property (nonatomic, retain) IBOutlet UILabel *serves;
@property (nonatomic, retain) IBOutlet UIImageView *thumb;
@property (nonatomic, retain) IBOutlet UIView *bg;
@end