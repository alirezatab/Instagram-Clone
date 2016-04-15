//
//  PostDetailViewController.m
//  Instagram
//
//  Created by Eric Hong on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ProfileCollectionViewCell.h"
#import "PostDetailViewController.h"
#import "FeedTableViewCell.h"
#import "CoreDataManager.h"
#import "User.h"
#import "Picture.h"
#import "Comment.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"
#import "CustomImageFlowLayout.h"

@interface PostDetailViewController () <UITableViewDelegate, UITableViewDataSource, likeButtonPressed>
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@end


@implementation PostDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    
    // tableView Nib
    [self.detailTableView registerNib:[UINib nibWithNibName:@"FeedTableViewCell" bundle:nil] forCellReuseIdentifier:@"postDetailCell"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.detailTableView reloadData];
}


#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postDetailCell" forIndexPath:indexPath];

    User *me = self.me;
    Picture *p = self.detailPictureObject;
    User *u = self.detailPictureObject.owner;
    
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
    cell.likeDelegate = self;
    
    return cell;
}
- (void)likeButtonPressed:(id)sender {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    FeedTableViewCell *cell = sender;
    Picture *p = self.detailPictureObject;
    
    // data
    User *me = self.me;
    if ([p isLikedBy:me]) {
        [p removeLikedByObject:me];
    } else {
        [p addLikedByObject:me];
    }
    [CoreDataManager save];
    
    // ui
    [cell.bottomLeft_heartButton setImage:[me getHeartIcon:p] forState:UIControlStateNormal];
    [self.detailTableView reloadData];
}


@end
