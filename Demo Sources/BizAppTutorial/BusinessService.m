//
//  BusinessService.m
//  BizAppTutorial
//
//  Created by Tope on 03/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusinessService.h"

@implementation BusinessService


@synthesize caption, image, webContent, webContentTitle, webContentImage;

-(id)initWithCaption:(NSString*)theCaption andImage:(UIImage*)theImage andWebContentTitle:(NSString*)theTitle andWebContent:(NSString*)theWebContent andWebContentImage:(UIImage*)theWebImage

{
    self = [super init];
    
    if(self)
    {
        self.caption= theCaption;
        self.image = theImage;
        self.webContent = theWebContent;
        self.webContentTitle = theTitle;
        self.webContentImage = theWebImage;
    }
    
    return self;
}


+(NSArray*)getSampleData
{
    
    
    NSString* content = @"<p>Corporate law is the study of how shareholders, directors, employees, creditors, and other stakeholders such as consumers, the community and the environment interact with one another. </p><p>The four defining characteristics of the modern corporation are:</p> <ul><li>Separate Legal Personality of the corporation (access to tort and contract law in a manner similar to a person)</li><li>Limited Liability of the shareholders</li><li>Shares (if the corporation is a public company, the shares are traded on a stock exchange)</li><li>Delegated Management; the board of directors delegates day-to-day management</li><ul>";
    
    BusinessService* service1 = [[BusinessService alloc] initWithCaption:@"PO Managment" andImage:[UIImage imageNamed:@"service-1.jpg"] andWebContentTitle:@"Litigation: Peace of mind with the experts" andWebContent:content andWebContentImage:[UIImage imageNamed:@"service-1.jpg"]];
    
    BusinessService* service2 = [[BusinessService alloc] initWithCaption:@"Tracking" andImage:[UIImage imageNamed:@"service-2.jpg"] andWebContentTitle:@"Employment Law: Know your rights" andWebContent:content andWebContentImage:[UIImage imageNamed:@"service-2.jpg"]];
    
    BusinessService* service3 = [[BusinessService alloc] initWithCaption:@"AMS" andImage:[UIImage imageNamed:@"service-3.jpg"] andWebContentTitle:@"Corporate Law: Organise your books" andWebContent:content andWebContentImage:[UIImage imageNamed:@"service-3.jpg"]];
    
    BusinessService* service4 = [[BusinessService alloc] initWithCaption:@"CHB" andImage:[UIImage imageNamed:@"service-4.png"] andWebContentTitle:@"Family Law: Make the right choice" andWebContent:content andWebContentImage:[UIImage imageNamed:@"service-4.jpg"]];
    
    BusinessService* service5 = [[BusinessService alloc] initWithCaption:@"24 Hour Support" andImage:[UIImage imageNamed:@"service-5.png"] andWebContentTitle:@"Mergers: Hamony between companies" andWebContent:content andWebContentImage:[UIImage imageNamed:@"service-5.jpg"]];
    
    
    BusinessService* service6 = [[BusinessService alloc] initWithCaption:@"Conveyancing" andImage:[UIImage imageNamed:@"service-6.png"] andWebContentTitle:@"Conveyancing: Make the right choice" andWebContent:content andWebContentImage:[UIImage imageNamed:@"service-6.jpg"]];
    
    return [NSArray arrayWithObjects:service1, service2, service3, service4, service5, service6, nil];
}

@end
