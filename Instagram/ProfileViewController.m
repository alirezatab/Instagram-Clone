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


@protocol hasUsers
@property NSArray *users;
@end


@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *profileSegmentedControl;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property NSArray *userPics;
@property NSManagedObjectContext *moc;
@end


@implementation ProfileViewController
- (void)viewDidLoad
{
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    [super viewDidLoad];
    
    // collectionView
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
    self.profileImageView.image = [UIImage imageNamed:@"Bulbasaur"];
    CALayer *imageLayer = self.profileImageView.layer;
    [imageLayer setCornerRadius:47];
    [imageLayer setMasksToBounds:YES];
    


    // tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"FeedTableViewCell" bundle:nil] forCellReuseIdentifier:@"feedCell"];

    // current user + feed
    // TODO: set self.user in parentVC (MainTabBar)
    self.user = [self coreGetUser0];
    self.userPics = [self.user.pictures allObjects];
    NSLog(@"user %@", self.user);
}



-(void)viewWillAppear:(BOOL)animated
{
    [self toggleHiddenStateOfCollectionAndTableView];
}

- (IBAction)onSegmentedControlPressed:(UISegmentedControl *)sender
{
    [self toggleHiddenStateOfCollectionAndTableView];
}

#pragma mark - Collection View Methods

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
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
}



#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
        return self.user.pictures.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedCell" forIndexPath:indexPath];
    
    // TODO: hook up buttons (username, location, heart, comment, numLikes, commentUser)
    
    Picture *p = self.userPics[indexPath.row];
    User *u = p.owner;
    
    cell.topLeft_profileImageView.image = [UIImage imageNamed:@"profile2"]; // TODO
    [cell.topLeft_usernameButton setTitle:u.username forState:UIControlStateNormal];
    [cell.topLeft_locationButton setTitle:@"somewhere in the desert, New Mexico" forState:UIControlStateNormal]; // TODO
    cell.topRight_timeLabel.text = @"2d"; // TODO
    cell.middle_mainImageView.image = [UIImage imageWithData:p.image];
    [cell.bottomLeft_numLikesButton setTitle:[NSString stringWithFormat:@"♥︎ %i likes", p.likedBy.count] forState:UIControlStateNormal];
    cell.bottomLeft_numLikesButton.hidden = (p.likedBy.count == 0);  // hide count if 0 likes

    // comments
    // TODO: multiple comment lines
    NSArray *comments = [p.comments allObjects];
    Comment *c = comments[0];
    [cell.bottomLeft_commentUserButton setTitle:c.user.username forState:UIControlStateNormal];
    cell.bottomLeft_commentTextLabel.text = c.text;
    cell.bottomLeft_commentDateLabel.text = @"today";

    return cell;
}
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

-(User *)coreGetUser0 {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    if (! self.moc) {
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        self.moc = appDelegate.managedObjectContext;
    }
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSError *error;
    NSArray *allUsers = [self.moc executeFetchRequest:req error:&error];
    if (error) {
        NSLog(@"core load error: %@", error);
        return nil;
    }
    NSLog(@"core load ok: %lu items", allUsers.count);

    return allUsers[0];
}







@end
