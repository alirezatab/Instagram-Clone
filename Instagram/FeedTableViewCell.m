//
//  FeedTableViewCell.m
//  Instagram
//
//  Created by Christopher Serra on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "FeedTableViewCell.h"


@implementation FeedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


#pragma mark - LikeButton
- (IBAction)onHeartButtonPressed:(UIButton *)sender {
    [self.likeDelegate likeButtonPressed:self];
}


@end
