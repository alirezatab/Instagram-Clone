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
#import "CustomImageFlowLayout.h"
#import <AVFoundation/AVFoundation.h>

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, likeButtonPressed>

#pragma mark - Outlets
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *profileSegmentedControl;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;

@property AVAudioPlayer *audioPlayer;

@end


@implementation ProfileViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));

    // layer
    CALayer *imageLayer = self.profileImageView.layer;
    [imageLayer setCornerRadius:30];
    [imageLayer setMasksToBounds:YES];
    
    // collectionView
    self.collectionView.collectionViewLayout = [[CustomImageFlowLayout alloc] init];
    self.collectionView.backgroundColor = [UIColor blackColor];
    
    // tableView - cell nib
    [self.tableView registerNib:[UINib nibWithNibName:@"FeedTableViewCell" bundle:nil] forCellReuseIdentifier:@"feedCell"];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // segment - default to tableview
    self.profileSegmentedControl.selectedSegmentIndex = 1;
    [self showCollectionOrTableView];
    
    // current user
    self.user = [self getMyUser];
    self.profileImageView.image = [UIImage imageNamed:@"profile2"];
    self.profileNameLabel.text = self.user.fullname;
    
    // current feed
    [self reloadAllData];
    
    // scroll to particular post (if specified by parentVC)
    if (self.scrollToPost) {
        int indexOfPost = [self.arrayOfPosts indexOfObject:self.scrollToPost];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexOfPost inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        self.scrollToPost = nil;
    } else {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


#pragma mark - Navigation - Segments
- (IBAction)onSegmentedControlPressed:(UISegmentedControl *)sender {
    [self showCollectionOrTableView];
    [self reloadAllData];
}
-(void)showCollectionOrTableView {
    if (self.profileSegmentedControl.selectedSegmentIndex == 0) {
        // 0: collectionview
        self.tableView.hidden = YES;
        self.collectionView.hidden = NO;
    } else if (self.profileSegmentedControl.selectedSegmentIndex == 1) {
        // 1: tableview
        self.tableView.hidden = NO;
        self.collectionView.hidden = YES;
    }
}



#pragma mark - Navigation - Segues
-(IBAction) unwindPlanetDestination: (UIStoryboardSegue *)sender{
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    //PlanetViewController *sourceVC = sender.sourceViewController;
}
// used for transition to single-post view
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toDetailView"]) {
        Picture *picture = self.arrayOfPosts[[self.collectionView indexPathForCell:sender].row];
        //NSLog(@"%@", picture);
        PostDetailViewController *dstVC = segue.destinationViewController;
        dstVC.detailPictureObject = picture;
        dstVC.me = self.user;
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
//-(CGSize)collectionView:(UICollectionView *)collectionView layout: (UICollectionView *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    return CGSizeMake(self.collectionView.frame.size.width / 5, self.collectionView.frame.size.height / 5);
//}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"BeepBoop" ofType:@"mp3"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    NSError *error;
//    self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
//    [self.audioPlayer play];
}



#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedCell" forIndexPath:indexPath];
    Picture *p = self.arrayOfPosts[indexPath.row];
    User *u = p.owner;
    User *me = self.user;

    // post
    cell.topLeft_profileImageView.image = [UIImage imageNamed:@"profile2"]; // TODO
    [cell.topLeft_usernameButton setTitle:u.username forState:UIControlStateNormal];
    [cell.topLeft_locationButton setTitle:p.location forState:UIControlStateNormal];
    cell.middle_mainImageView.image = [UIImage imageWithData:p.image];
    [cell.bottomLeft_numLikesButton setTitle:[NSString stringWithFormat:@"♥︎ %lu likes", p.likedBy.count] forState:UIControlStateNormal];

    // comments
    NSArray *comments = [p.comments allObjects];
    Comment *c = comments[0];
    [cell.bottomLeft_commentUserButton setTitle:c.user.username forState:UIControlStateNormal];
    cell.bottomLeft_commentTextLabel.text = c.text;
    cell.bottomLeft_commentDateLabel.text = c.agoString;

    // heart button
    [cell.bottomLeft_heartButton setImage:[me getHeartIcon:p] forState:UIControlStateNormal];

    // delegate
    cell.likeDelegate = self;
    
    return cell;
}


#pragma mark - TableView - Delete
// swipe to delete
// canEditRowAtIndexPath: YES
// commitEditingStyle: removeObject(CoreData) + deleteRows(TableView)
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    int i = indexPath.row;
    Picture *deletedPicture = self.arrayOfPosts[i];

    // delete all comments
    NSArray *deletedComments = [deletedPicture.comments allObjects];
    for (Comment *c in deletedComments) {
        [CoreDataManager deleteObject:c];
    }

    // delete picture
    [CoreDataManager deleteObject:deletedPicture];

    [CoreDataManager save];
    [self reloadAllData];
}


#pragma mark - TableView - Likes
//- (UIImage *)selectHeartIcon:(Picture *)p {
//    NSString *heartIconName = ([p isLikedBy:self.user]) ? (@"button-heart-on") : (@"button-heart-off");
//    return [UIImage imageNamed:heartIconName];
//}
- (void)likeButtonPressed:(id)sender {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    FeedTableViewCell *cell = sender;
    int i = [self.tableView indexPathForCell:cell].row;
    Picture *p = self.arrayOfPosts[i];

    // data
    User *me = self.user;
    if ([p isLikedBy:me]) {
        [p removeLikedByObject:me];
    } else {
        [p addLikedByObject:me];
    }
    [CoreDataManager save];
    
    // ui
    [cell.bottomLeft_heartButton setImage:[me getHeartIcon:p] forState:UIControlStateNormal];
    [self reloadAllData];
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
//    } else {
//        return @"Section 3";
//    }
//}


#pragma mark - Data
-(void)reloadAllData {
    self.arrayOfPosts = [self sortPicturesByDate:[self.user.pictures allObjects]];
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

-(NSArray *)sortPicturesByDate:(NSArray *)oldArray {
    return [oldArray sortedArrayUsingComparator:
            ^NSComparisonResult(Picture *p1, Picture *p2) {
                return [p2.time compare:p1.time];
            }];
}

// getMyUser() - returns User object for current user
-(User *)getMyUser {
    return [CoreDataManager getUserZero];
}



// TODO: multiple comment lines
// TODO: hook up buttons (username, location, comment, numLikes, commentUser)



@end
