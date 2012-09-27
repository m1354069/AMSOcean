
#import "MenuViewController.h"
#import "MenuCustomCell.h"
#import "MenuDetailView.h"
#import "AFImageCache.h"
#import "UIImageView+AFNetworking.h"
#import "AFJSONRequestOperation.h"
#import "SVProgressHUD.h"

@implementation MenuViewController
@synthesize menuTable;
@synthesize ids, titleData, priceData, servesData, thumbData, descriptionData;
@synthesize savedSearchTerm, savedScopeButtonIndex, searchWasActive;
@synthesize filteredIds, filteredPrices, filteredServes, filteredThumbs, filteredTitles, filteredDescription;
//@synthesize menuDetailView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        menuCell = [[UINib nibWithNibName:@"MenuCustomCell" bundle:[NSBundle mainBundle]] retain];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.menuTable deselectRowAtIndexPath:[self.menuTable indexPathForSelectedRow] animated:YES];
}

- (void)dealloc
{
    [menuCell release];
    [ids release];
    [titleData release];
    [priceData release];
    [servesData release];
    [thumbData release];
    [descriptionData release];
    [filteredTitles release];
    [filteredThumbs release];
    [filteredServes release];
    [filteredPrices release];
    [filteredIds release];
    [super dealloc];
}

- (void)getDinnerItems {
    //HUD
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.delegate = self;
    HUD.labelText = @"Loading...";
    [HUD show:TRUE];
    
    //Site root, initial path to image thumbs, minus /images/category/image.jpg
    NSString *root = @"http://dev.zeusdeveloper.com/REST/RestaurantCMS";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/getDinner.php", root]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        [self.ids removeAllObjects];
        [self.titleData removeAllObjects];
        [self.priceData removeAllObjects];
        [self.servesData removeAllObjects];
        [self.thumbData removeAllObjects];
        [self.descriptionData removeAllObjects];
        
        id results = [JSON valueForKeyPath:@"items"];
        
        [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self.ids addObject:[NSString stringWithFormat:@"%@",[obj valueForKey:@"ID"]]];
            [self.titleData addObject:[NSString stringWithFormat:@"%@",[obj valueForKey:@"Title"]]];
            [self.priceData addObject:[NSString stringWithFormat:@"%@",[obj valueForKey:@"Price"]]];
            [self.servesData addObject:[NSString stringWithFormat:@"%@",[obj valueForKey:@"Serves"]]];
            [self.thumbData addObject:[NSString stringWithFormat:@"%@%@",root,[obj valueForKey:@"ImageURL"]]];
            [self.descriptionData addObject:[NSString stringWithFormat:@"%@",[obj valueForKey:@"Description"]]];
        }];
        
        [self.menuTable reloadData];
        [self.menuTable setNeedsDisplay]; 
        [HUD hide:TRUE];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [HUD hide:TRUE];
        [SVProgressHUD showInView:self.view];
        [SVProgressHUD dismissWithError:[error localizedDescription]];
        //NSLog(@"%@",[error localizedDescription]);
    }];
    
    NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
    [queue addOperation:operation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Table refresh
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.menuTable.bounds.size.height, self.view.frame.size.width, self.menuTable.bounds.size.height)];
		view.delegate = self;
		[self.menuTable addSubview:view];
		_refreshHeaderView = view;
		[view release];
	}
    
    //Add the search bar
    sBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    sBar.barStyle = UIBarStyleDefault;
    sBar.showsCancelButton = NO;
    sBar.autocorrectionType = UITextAutocorrectionTypeNo;
    sBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    sBar.scopeButtonTitles = [NSArray arrayWithObjects:@"All",@"Name",@"Price",@"Serves",@"Desc.",nil];
    sBar.delegate = self;
    menuTable.tableHeaderView = sBar;
    //Search bar tint color black
    sBar.tintColor = [UIColor blackColor];
    [sBar release];
    //And the controller
    searchController = [[UISearchDisplayController alloc] initWithSearchBar:sBar contentsController:self];
    searchController.searchResultsTableView.rowHeight = menuTable.rowHeight;
    searchController.searchResultsDataSource = self;
    searchController.searchResultsDelegate = self;
    searchController.delegate = self;
    
    self.filteredIds = [NSMutableArray arrayWithCapacity:[self.ids count]];
    self.filteredTitles = [NSMutableArray arrayWithCapacity:[self.titleData count]];
    self.filteredPrices = [NSMutableArray arrayWithCapacity:[self.priceData count]];
    self.filteredServes = [NSMutableArray arrayWithCapacity:[self.servesData count]];
    self.filteredThumbs = [NSMutableArray arrayWithCapacity:[self.thumbData count]];
    self.filteredDescription = [NSMutableArray arrayWithCapacity:[self.descriptionData count]];
    
    // restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
	{
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
    
    //Initiate arrays that hold data
    ids = [[NSMutableArray alloc] init];
    titleData = [[NSMutableArray alloc] init];
    priceData = [[NSMutableArray alloc] init];
    servesData = [[NSMutableArray alloc] init];
    thumbData = [[NSMutableArray alloc] init];
    descriptionData = [[NSMutableArray alloc] init];
    [self.ids removeAllObjects];
    [self.titleData removeAllObjects];
    [self.priceData removeAllObjects];
    [self.servesData removeAllObjects];
    [self.thumbData removeAllObjects];
    [self.descriptionData removeAllObjects];
    
    [self getDinnerItems];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.menuTable = nil;
    _refreshHeaderView = nil;
    
    self.titleData = nil;
    self.priceData = nil;
    self.servesData = nil;
    self.ids = nil;
    self.thumbData = nil;
    self.descriptionData = nil;
    
    self.filteredTitles = nil;
    self.filteredThumbs = nil;
    self.filteredServes = nil;
    self.filteredPrices = nil;
    self.filteredIds = nil;
    self.filteredDescription = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // save the state of the search UI so that it can be restored if the view is re-created
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredIds count];
    } else {
        return [self.ids count];
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Note: I set the cell's Identifier property in Interface Builder to MenuCellID.
    MenuCustomCell *cell = (MenuCustomCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuCellID"];
    if (!cell)
    {
        NSArray *topLevelItems = [menuCell instantiateWithOwner:self options:nil];
        cell = [topLevelItems objectAtIndex:0];
    }

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [[cell title] setText:[filteredTitles objectAtIndex:indexPath.row]];
        [[cell price] setText:[NSString stringWithFormat:@"%@", [filteredPrices objectAtIndex:indexPath.row]]];
        [[cell serves] setText:[NSString stringWithFormat:@"%@", [filteredServes objectAtIndex:indexPath.row]]];
        //Set the image with async technology
        [[cell thumb] setImageWithURL:[NSURL URLWithString:[filteredThumbs objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        //Alternating background colors
        if (indexPath.row % 2 == 0) {
            [[cell bg] setBackgroundColor:[UIColor colorWithRed:219./255.0 green:219.0/255.0 blue:219.0/255.0 alpha:.4]];
        } else {
            [[cell bg] setBackgroundColor:[UIColor whiteColor]];
        }
    } else {
        [[cell title] setText:[titleData objectAtIndex:indexPath.row]];
        [[cell price] setText:[NSString stringWithFormat:@"%@", [priceData objectAtIndex:indexPath.row]]];
        [[cell serves] setText:[NSString stringWithFormat:@"%@", [servesData objectAtIndex:indexPath.row]]];
        //Set the image with async technology
        [[cell thumb] setImageWithURL:[NSURL URLWithString:[thumbData objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        //Alternating background colors
        if (indexPath.row % 2 == 0) {
            [[cell bg] setBackgroundColor:[UIColor colorWithRed:219./255.0 green:219.0/255.0 blue:219.0/255.0 alpha:.4]];
        } else {
            [[cell bg] setBackgroundColor:[UIColor whiteColor]];
        }
    }
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        /**
        MenuDetailView *detail = [[MenuDetailView alloc] initWithNibName:@"MenuDetailView" bundle:nil];
        self.menuDetailView = detail;
        [detail release];
                
        menuDetailView.title = [NSString stringWithFormat:@"%@",[filteredTitles objectAtIndex:indexPath.row]];
        menuDetailView.itemID = [NSString stringWithFormat:@"%@",[filteredIds objectAtIndex:indexPath.row]];
        menuDetailView.iconURL = [NSString stringWithFormat:@"%@",[filteredThumbs objectAtIndex:indexPath.row]];
        menuDetailView.itemName = [NSString stringWithFormat:@"%@",[filteredTitles objectAtIndex:indexPath.row]];
        menuDetailView.description = [NSString stringWithFormat:@"%@",[filteredDescription objectAtIndex:indexPath.row]];
        menuDetailView.price = [NSString stringWithFormat:@"%@",[filteredPrices objectAtIndex:indexPath.row]];
        menuDetailView.serves = [NSString stringWithFormat:@"Serves %@",[filteredServes objectAtIndex:indexPath.row]];
        
        [self.navigationController pushViewController:menuDetailView animated:YES];
    } else {
        MenuDetailView *detail = [[MenuDetailView alloc] initWithNibName:@"MenuDetailView" bundle:nil];
        self.menuDetailView = detail;
        [detail release];
        
        menuDetailView.title = [NSString stringWithFormat:@"%@",[titleData objectAtIndex:indexPath.row]];
        menuDetailView.itemID = [NSString stringWithFormat:@"%@",[ids objectAtIndex:indexPath.row]];
        menuDetailView.iconURL = [NSString stringWithFormat:@"%@",[thumbData objectAtIndex:indexPath.row]];
        menuDetailView.itemName = [NSString stringWithFormat:@"%@",[titleData objectAtIndex:indexPath.row]];
        menuDetailView.description = [NSString stringWithFormat:@"%@",[descriptionData objectAtIndex:indexPath.row]];
        menuDetailView.price = [NSString stringWithFormat:@"%@",[priceData objectAtIndex:indexPath.row]];
        menuDetailView.serves = [NSString stringWithFormat:@"Serves %@",[servesData objectAtIndex:indexPath.row]];
        
        [self.navigationController pushViewController:menuDetailView animated:YES];
         */
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

#pragma mark -
#pragma mark UISearchBar Methods
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{  
    searchController.searchResultsTableView.rowHeight = menuTable.rowHeight;
    
    [self.filteredIds removeAllObjects];
    [self.filteredTitles removeAllObjects];
    [self.filteredPrices removeAllObjects];
    [self.filteredServes removeAllObjects];
    [self.filteredThumbs removeAllObjects];
    [self.filteredDescription removeAllObjects];
    
    for (int i = 0; i < [ids count]; i++) {
        if ([scope isEqualToString:@"All"]) {
            sBar.placeholder = @"Search";
            
            //Use NSRange to be able to search entire string instead of just matching the beginning
            NSRange titleRange = [[titleData objectAtIndex:i] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            NSRange priceSearch = [[priceData objectAtIndex:i] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            NSComparisonResult servesSearch = [[servesData objectAtIndex:i] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            
            NSRange descriptionSearch = [[descriptionData objectAtIndex:i] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (titleRange.location != NSNotFound || priceSearch.location != NSNotFound || servesSearch == NSOrderedSame || descriptionSearch.location != NSNotFound)
            {
                [self.filteredIds addObject:[ids objectAtIndex:i]];
                [self.filteredTitles addObject:[titleData objectAtIndex:i]];
                [self.filteredPrices addObject:[priceData objectAtIndex:i]];
                [self.filteredServes addObject:[servesData objectAtIndex:i]];
                [self.filteredThumbs addObject:[thumbData objectAtIndex:i]];
                [self.filteredDescription addObject:[descriptionData objectAtIndex:i]];
            }
        }
        else if ([scope isEqualToString:@"Name"]) {
            sBar.placeholder = @"Search Names";
            
            NSRange titleRange = [[titleData objectAtIndex:i] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (titleRange.location != NSNotFound)
            {
                [self.filteredIds addObject:[ids objectAtIndex:i]];
                [self.filteredTitles addObject:[titleData objectAtIndex:i]];
                [self.filteredPrices addObject:[priceData objectAtIndex:i]];
                [self.filteredServes addObject:[servesData objectAtIndex:i]];
                [self.filteredThumbs addObject:[thumbData objectAtIndex:i]];
               [self.filteredDescription addObject:[descriptionData objectAtIndex:i]];
            }
        }
        else if ([scope isEqualToString:@"Price"]) {
            sBar.placeholder = @"Search Prices";
            
            NSRange priceSearch = [[priceData objectAtIndex:i] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (priceSearch.location != NSNotFound)
            {
                [self.filteredIds addObject:[ids objectAtIndex:i]];
                [self.filteredTitles addObject:[titleData objectAtIndex:i]];
                [self.filteredPrices addObject:[priceData objectAtIndex:i]];
                [self.filteredServes addObject:[servesData objectAtIndex:i]];
                [self.filteredThumbs addObject:[thumbData objectAtIndex:i]];
                [self.filteredDescription addObject:[descriptionData objectAtIndex:i]];
            }
        }
        else if ([scope isEqualToString:@"Serves"]) {
            sBar.placeholder = @"Search Serving Sizes";
            
            NSComparisonResult servesSearch = [[servesData objectAtIndex:i] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            
            if (servesSearch == NSOrderedSame)
            {
                [self.filteredIds addObject:[ids objectAtIndex:i]];
                [self.filteredTitles addObject:[titleData objectAtIndex:i]];
                [self.filteredPrices addObject:[priceData objectAtIndex:i]];
                [self.filteredServes addObject:[servesData objectAtIndex:i]];
                [self.filteredThumbs addObject:[thumbData objectAtIndex:i]];
                [self.filteredDescription addObject:[descriptionData objectAtIndex:i]];
            }
        }
        else if ([scope isEqualToString:@"Desc."]) {
            sBar.placeholder = @"Descriptions";
            
            NSRange descriptionSearch = [[descriptionData objectAtIndex:i] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (descriptionSearch.location != NSNotFound)
            {
                [self.filteredIds addObject:[ids objectAtIndex:i]];
                [self.filteredTitles addObject:[titleData objectAtIndex:i]];
                [self.filteredPrices addObject:[priceData objectAtIndex:i]];
                [self.filteredServes addObject:[servesData objectAtIndex:i]];
                [self.filteredThumbs addObject:[thumbData objectAtIndex:i]];
                [self.filteredDescription addObject:[descriptionData objectAtIndex:i]];
            }
        }
    }
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    return YES;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
    [self getDinnerItems];
}
- (void)doneLoadingTableViewData{
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.menuTable];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{	
	return _reloading; // should return if data source model is reloading
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{	
	return [NSDate date]; // should return date data source was last changed
}
@end
