//
//  ProfileViewController.m
//  Instagram
//
//  Created by Eric Hong on 4/9/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCollectionViewCell.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *profileSegmentedControl;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayOfPosts = [NSMutableArray new];
    self.arrayOfPosts = [@[[UIImage imageNamed:@"Charmander"],
                           [UIImage imageNamed:@"Bulbasaur"],
                           [UIImage imageNamed:@"Evee"],
                           [UIImage imageNamed:@"Arcanine"],
                           [UIImage imageNamed:@"Nidoran"],
                           [UIImage imageNamed:@"Vaporeon"],
                           [UIImage imageNamed:@"Charmander"],
                           [UIImage imageNamed:@"Bulbasaur"],
                           [UIImage imageNamed:@"Evee"],
                           [UIImage imageNamed:@"Arcanine"],
                           [UIImage imageNamed:@"Nidoran"],
                           [UIImage imageNamed:@"Vaporeon"],
                           [UIImage imageNamed:@"Charmander"],
                           [UIImage imageNamed:@"Bulbasaur"],
                           [UIImage imageNamed:@"Evee"],
                           [UIImage imageNamed:@"Arcanine"],
                           [UIImage imageNamed:@"Nidoran"],
                           [UIImage imageNamed:@"Vaporeon"],
                           [UIImage imageNamed:@"Charmander"],
                           [UIImage imageNamed:@"Bulbasaur"],
                           [UIImage imageNamed:@"Evee"],
                           [UIImage imageNamed:@"Arcanine"],
                           [UIImage imageNamed:@"Nidoran"],
                           [UIImage imageNamed:@"Vaporeon"],
                           [UIImage imageNamed:@"Charmander"],
                           [UIImage imageNamed:@"Bulbasaur"],
                           [UIImage imageNamed:@"Evee"],
                           [UIImage imageNamed:@"Arcanine"],
                           [UIImage imageNamed:@"Nidoran"],
                           [UIImage imageNamed:@"Vaporeon"],
                           [UIImage imageNamed:@"Charmander"],
                           [UIImage imageNamed:@"Bulbasaur"],
                           [UIImage imageNamed:@"Evee"],
                           [UIImage imageNamed:@"Arcanine"],
                           [UIImage imageNamed:@"Nidoran"],
                           [UIImage imageNamed:@"Vaporeon"]]mutableCopy];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self toggleHiddenStateOfCollectionAndTableView];
}

- (IBAction)onSegmentedControlPressed:(UISegmentedControl *)sender
{
    [self toggleHiddenStateOfCollectionAndTableView];
}

#pragma - Collection View Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrayOfPosts.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    collectionView.backgroundColor = [UIColor blackColor];
    collectionCell.imageView.image = self.arrayOfPosts[indexPath.row];
    
    return collectionCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout: (UICollectionView *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.frame.size.width / 5, self.collectionView.frame.size.height / 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma - Table View Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];

    
    cell.textLabel.text = @"Hello";

    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    if (section == 0)
    {
        return @"Section 1";
    }
    else if (section == 1)
    {
        return @"Section 2";
    }
    else if (section == 2)
    {
        return @"Section 3";
    }
    else if (section == 3)
    {
        return @"Section 4";
    }
    else
    {
        return @"Section 5";
    }
    
}

#pragma - Custom Functions

//  Hides the table view or collection view depending on which segmented control was selected
-(void)toggleHiddenStateOfCollectionAndTableView
{
    if (self.profileSegmentedControl.selectedSegmentIndex == 0)
    {
        self.tableView.hidden = YES;
        self.collectionView.hidden = NO;
    }
    else if (self.profileSegmentedControl.selectedSegmentIndex == 1)
    {
        self.tableView.hidden = NO;
        self.collectionView.hidden = YES;
    }
}







@end
