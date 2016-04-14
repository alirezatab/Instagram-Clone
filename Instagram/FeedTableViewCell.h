//
//  FeedTableViewCell.h
//  Instagram
//
//  Created by Christopher Serra on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol likeButtonPressed
-(void)likeButtonPressed:(id)sender;
@end

@interface FeedTableViewCell : UITableViewCell
// top
@property (weak, nonatomic) IBOutlet UIImageView *topLeft_profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *topLeft_usernameButton;
@property (weak, nonatomic) IBOutlet UIButton *topLeft_locationButton;
// middle
@property (weak, nonatomic) IBOutlet UIImageView *middle_mainImageView;
// bottom
@property (weak, nonatomic) IBOutlet UIButton *bottomLeft_heartButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomLeft_commentButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomLeft_numLikesButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomLeft_commentUserButton;
@property (weak, nonatomic) IBOutlet UILabel *bottomLeft_commentTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLeft_commentDateLabel;
// delegates
@property id<likeButtonPressed> likeDelegate;
@end
