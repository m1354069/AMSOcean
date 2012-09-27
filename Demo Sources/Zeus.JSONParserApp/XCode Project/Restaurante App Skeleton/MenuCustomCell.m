//
//  MenuCustomCell.m
//  Restaurante App Skeleton
//
//  Created by Anthony on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuCustomCell.h"

@implementation MenuCustomCell
@synthesize title, price, serves, thumb, bg;

- (void)dealloc 
{
    [super dealloc];
    [title release];
    [price release];
    [serves release];
    [thumb release];
    [bg release];
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    thumb.layer.cornerRadius = 5.0;
    thumb.clipsToBounds = YES;
    thumb.layer.borderColor = [[UIColor blackColor] CGColor];
    thumb.layer.borderWidth = 2.0;
}

@end
