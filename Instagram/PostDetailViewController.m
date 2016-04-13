//
//  PostDetailViewController.m
//  Instagram
//
//  Created by Eric Hong on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "PostDetailViewController.h"
#import "FeedTableViewCell.h"
#import "CoreDataManager.h"
#import "User.h"
#import "Picture.h"
#import "Comment.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"

@interface PostDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation PostDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postDetailCell" forIndexPath:indexPath];
    
//    ProfileViewController *profileVCReference;
//    
//    Picture *p = profileVCReference.arrayOfPosts[indexPath.row];
//    User *u = p.owner;
//    
//    // post
//    cell.topLeft_profileImageView.image = [UIImage imageNamed:@"profile2"]; // TODO
//    [cell.topLeft_usernameButton setTitle:u.username forState:UIControlStateNormal];
//    [cell.topLeft_locationButton setTitle:p.location forState:UIControlStateNormal];
//    cell.middle_mainImageView.image = [UIImage imageWithData:p.image];
//    [cell.bottomLeft_numLikesButton setTitle:[NSString stringWithFormat:@"♥︎ %lu likes", p.likedBy.count] forState:UIControlStateNormal];
//    
//    // comments
//    NSArray *comments = [p.comments allObjects];
//    Comment *c = comments[0];
//    [cell.bottomLeft_commentUserButton setTitle:c.user.username forState:UIControlStateNormal];
//    cell.bottomLeft_commentTextLabel.text = c.text;
//    cell.bottomLeft_commentDateLabel.text = @"today";
    
    // TODO: multiple comment lines
    // TODO: hook up buttons (username, location, heart, comment, numLikes, commentUser)
    
    return cell;
}

- (IBAction)onBackButtonPressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
