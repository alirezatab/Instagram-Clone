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

@interface PostDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;



@end

@implementation PostDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    
    // tableView Nib
    [self.detailTableView registerNib:[UINib nibWithNibName:@"FeedTableViewCell" bundle:nil] forCellReuseIdentifier:@"postDetailCell"];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postDetailCell" forIndexPath:indexPath];
    User *user = self.detailPictureObject.owner;
    
    cell.topLeft_profileImageView.image = [UIImage imageNamed:@"profile2"];
    [cell.topLeft_usernameButton setTitle:user.username forState:UIControlStateNormal];
    [cell.topLeft_locationButton setTitle:_detailPictureObject.location forState:UIControlStateNormal];
    cell.middle_mainImageView.image = [UIImage imageWithData:self.detailPictureObject.image];
    [cell.bottomLeft_numLikesButton setTitle:[NSString stringWithFormat:@"♥︎ %lu likes", self.detailPictureObject.likedBy.count] forState:UIControlStateNormal];
    
    NSArray *comments = [self.detailPictureObject.comments allObjects];
    Comment *c = comments[0];
    [cell.bottomLeft_commentUserButton setTitle:c.user.username forState:UIControlStateNormal];
    cell.bottomLeft_commentTextLabel.text = c.text;
    cell.bottomLeft_commentDateLabel.text = c.agoString;
    
//    cell.likeDelegate = self;
    
    return cell;
}

-(NSString *)secsAgoString:(int)nSecs div:(int)div unit:(NSString *)unit plural:(BOOL)plural {
    int x = (int)(nSecs/div);
    NSString *unitStr = unit;
    if (plural && x != 1) { unitStr = [NSString stringWithFormat:@"%@s", unitStr]; }
    return [NSString stringWithFormat:@"%i %@ ago", x, unitStr];
}
-(NSString *)commentTime:(Comment *)c {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    NSDate *time = c.time;
    NSDate *now = [NSDate date];
    NSTimeInterval n = [now timeIntervalSinceDate:time];
    NSLog(@"%.0lf sec ago", n);
    
    // 604,800 sec/wk
    // 86,400 sec/day
    // 3600 sec/hr
    // 60 sec/min
    if (n >= 604800) {
        return [self secsAgoString:n div:604800 unit:@"wk" plural:YES];
    } else if (n >= 86400) {
        return [self secsAgoString:n div:86400 unit:@"day" plural:YES];
    } else if (n >= 3600) {
        return [self secsAgoString:n div:3600 unit:@"hr" plural:YES];
    } else if (n >= 60) {
        return [self secsAgoString:n div:60 unit:@"min" plural:NO];
    }
    return [self secsAgoString:n div:1 unit:@"sec" plural:NO];
}

- (IBAction)onBackButtonPressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(User *)getMyUser {
    return [CoreDataManager getUserZero];
}


@end
