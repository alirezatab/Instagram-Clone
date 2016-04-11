//
//  FeedTableViewCell.h
//  Instagram
//
//  Created by Christopher Serra on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedTableViewCell : UITableViewCell
// top left
@property (weak, nonatomic) IBOutlet UIImageView *topLeft_profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *topLeft_usernameButton;
@property (weak, nonatomic) IBOutlet UIButton *topLeft_locationButton;
// top right
@property (weak, nonatomic) IBOutlet UILabel *topRight_timeLabel;
// middle
@property (weak, nonatomic) IBOutlet UIImageView *middle_mainImageView;
// bottom right
@property (weak, nonatomic) IBOutlet UIButton *bottomLeft_heartButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomLeft_commentButton;

@end
