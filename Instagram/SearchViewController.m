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

    self.rawArray = [CoreDataManager fetchComments];
    self.filteredArray = [NSArray arrayWithArray:self.rawArray];
 }


#pragma mark - SearchBar
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"[%@ %@] >%@<", self.class, NSStringFromSelector(_cmd), searchText);
    self.filteredArray = [self filterArray:self.rawArray with:searchText];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
