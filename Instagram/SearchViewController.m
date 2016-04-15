//
//  SearchViewController.m
//  Instagram
//
//  Created by Eric Hong on 4/12/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "SearchViewController.h"
#import "CoreDataManager.h"
#import "User.h"
#import "Picture.h"
#import "Comment.h"
#import "ProfileViewController.h"


@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *rawArray;
@property NSArray *filteredArray;
@end


@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //tableview
    self.tableView.delegate = self;
    
    // search bar
    self.searchBar.delegate = self;
    
    // search results
    self.rawArray = [NSArray new];
    self.filteredArray = [NSArray new];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.rawArray = [CoreDataManager fetchComments];
    self.rawArray = [self.rawArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Comment *c1 = obj1;
        Comment *c2 = obj2;
        return [c1.text.lowercaseString compare:c2.text.lowercaseString];
    }];
    self.filteredArray = [NSArray arrayWithArray:self.rawArray];
}

#pragma mark - SearchBar
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"[%@ %@] >%@<", self.class, NSStringFromSelector(_cmd), searchText);
    self.filteredArray = [self filterArray:self.rawArray with:searchText];
    self.filteredArray = [self.filteredArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Comment *c1 = obj1;
        Comment *c2 = obj2;
        return [c1.text.lowercaseString compare:c2.text.lowercaseString];
    }];
    [self.tableView reloadData];
}
-(NSArray *)filterArray:(NSArray *)oldArray with:(NSString *)filterString{
    if ([filterString isEqualToString:@""]) { return oldArray; }
    NSMutableArray *newArray = [NSMutableArray new];
    
    NSString *filterStringLower = [filterString lowercaseString];
    for (Comment *x in oldArray) {      // CUSTOM
        NSString *elemText = x.text;    // CUSTOM
        NSString *elemTextLower = [elemText lowercaseString];
        if ([elemTextLower containsString:filterStringLower]) {
            [newArray addObject:x];
        }
    }
    
    return [NSArray arrayWithArray:newArray];
}



#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filteredArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];

    Comment *c = self.filteredArray[indexPath.row];
    cell.textLabel.text = c.text;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@ (%@)", c.picture.owner.username, c.agoString, c.picture.location];


    return cell;
}


#pragma mark - Navigation
// on search result selected, navigate to Profile feed view + scroll to that Picture
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"[%@ %@] %i", self.class, NSStringFromSelector(_cmd), indexPath.row);
    Comment *c = self.filteredArray[indexPath.row];
    Picture *p = c.picture;

    // pass data to Profile VC
    int profileTabIndex = 4;
    UITabBarController *tabVC = self.tabVC;
    UINavigationController *nav = tabVC.viewControllers[profileTabIndex];
    ProfileViewController *dstVC = nav.topViewController;
    dstVC.scrollToPost = c.picture;

    // switch to Profile tab
    tabVC.selectedIndex = profileTabIndex;
}


@end
