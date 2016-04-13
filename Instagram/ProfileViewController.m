//
//  ProfileViewController.m
//  Instagram
//
//  Created by Eric Hong on 4/9/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ProfileViewController.h"
#import "ProfileCollectionViewCell.h"
#import "PostDetailViewController.h"
#import "FeedTableViewCell.h"
#import "User.h"
#import "Picture.h"
#import "Comment.h"
#import "AppDelegate.h"
#import "CoreDataManager.h"


@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *profileSegmentedControl;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@end


@implementation ProfileViewController
- (void)viewDidLoad
{
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    [super viewDidLoad];

    // layer
    CALayer *imageLayer = self.profileImageView.layer;
    [imageLayer setCornerRadius:30];
    [imageLayer setMasksToBounds:YES];
    
    // tableView Nib
    [self.tableView registerNib:[UINib nibWithNibName:@"FeedTableViewCell" bundle:nil] forCellReuseIdentifier:@"feedCell"];
}
-(void)viewWillAppear:(BOOL)animated {
    [self selectCollectionOrTableView];
    
    // current user
    self.user = [self getMyUser];

    // current feed
    self.arrayOfPosts = [self.user.pictures allObjects];
    [self.tableView reloadData];
}



#pragma mark - Navigation
- (IBAction)onSegmentedControlPressed:(UISegmentedControl *)sender {
    [self selectCollectionOrTableView];
}
//  toggle() - Hides the table view or collection view depending on which segmented control was selected
-(void)selectCollectionOrTableView
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



#pragma mark - CollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];

    Picture *p = self.arrayOfPosts[indexPath.row];
    collectionCell.imageView.image = [UIImage imageWithData:p.image];
    collectionView.backgroundColor = [UIColor blackColor];

    return collectionCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout: (UICollectionView *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width / 5, self.collectionView.frame.size.height / 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
}



#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedCell" forIndexPath:indexPath];
    Picture *p = self.arrayOfPosts[indexPath.row];
    User *u = p.owner;

    // post
    cell.topLeft_profileImageView.image = [UIImage imageNamed:@"profile2"]; // TODO
    [cell.topLeft_usernameButton setTitle:u.username forState:UIControlStateNormal];
    [cell.topLeft_locationButton setTitle:p.location forState:UIControlStateNormal];
    cell.middle_mainImageView.image = [UIImage imageWithData:p.image];
    [cell.bottomLeft_numLikesButton setTitle:[NSString stringWithFormat:@"♥︎ %i likes", p.likedBy.count] forState:UIControlStateNormal];

    // comments
    NSArray *comments = [p.comments allObjects];
    Comment *c = comments[0];
    [cell.bottomLeft_commentUserButton setTitle:c.user.username forState:UIControlStateNormal];
    cell.bottomLeft_commentTextLabel.text = c.text;
    cell.bottomLeft_commentDateLabel.text = @"today";

    // TODO: multiple comment lines
    // TODO: hook up buttons (username, location, heart, comment, numLikes, commentUser)

    return cell;
}


#pragma mark - TableView - Sections
// tableView sections
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 5;
//}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return @"Section 1";
//    } else if (section == 1) {
//        return @"Section 2";
//    } else if (section == 2) {
//        return @"Section 3";
//    } else if (section == 3) {
//        return @"Section 4";
//    } else {
//        return @"Section 5";
//    }
//}



#pragma mark - Custom Functions
// getMyUser() - returns User object for current user
-(User *)getMyUser {
    return [CoreDataManager getUserZero];
}







@end
