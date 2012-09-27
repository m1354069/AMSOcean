//
//  MenuViewController.h
//  Restaurante App Skeleton
//
//  Created by Anthony on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "EGORefreshTableHeaderView.h"

@class MenuDetailView;

@interface DrinksViewController : UIViewController <MBProgressHUDDelegate, UITableViewDelegate, UITableViewDataSource, EGORefreshTableHeaderDelegate, UISearchBarDelegate, UISearchDisplayDelegate> {
    UITableView *drinksTable;
    UINib *menuCell;
    
    //HUD
    MBProgressHUD *HUD;
    
    //For table pull to refresh
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
    
    //Vars to hold json data
    NSMutableArray *ids;
    NSMutableArray *titleData;
    NSMutableArray *priceData;
    NSMutableArray *servesData;
    NSMutableArray *thumbData;
    NSMutableArray *descriptionData;
    
    //Searchbar stuff
    UISearchBar *sBar;
    UISearchDisplayController *searchController;
    // The saved state of the search UI if a memory warning removed the view.
    NSString		*savedSearchTerm;
    NSInteger		savedScopeButtonIndex;
    NSMutableArray *filteredIds;
    NSMutableArray *filteredTitles;
    NSMutableArray *filteredPrices;
    NSMutableArray *filteredServes;
    NSMutableArray *filteredThumbs;
    NSMutableArray *filteredDescription;
    
    MenuDetailView *menuDetailView;
}
@property (nonatomic, retain) IBOutlet UITableView *drinksTable;

@property (nonatomic, retain) NSMutableArray *ids;
@property (nonatomic, retain) NSMutableArray *titleData;
@property (nonatomic, retain) NSMutableArray *priceData;
@property (nonatomic, retain) NSMutableArray *servesData;
@property (nonatomic, retain) NSMutableArray *thumbData;
@property (nonatomic, retain) NSMutableArray *descriptionData;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;
@property (nonatomic, retain) NSMutableArray *filteredIds;
@property (nonatomic, retain) NSMutableArray *filteredTitles;
@property (nonatomic, retain) NSMutableArray *filteredPrices;
@property (nonatomic, retain) NSMutableArray *filteredServes;
@property (nonatomic, retain) NSMutableArray *filteredThumbs;
@property (nonatomic, retain) NSMutableArray *filteredDescription;

@property (nonatomic, retain) MenuDetailView *menuDetailView;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end