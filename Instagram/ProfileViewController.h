//
//  ProfileViewController.h
//  Instagram
//
//  Created by Eric Hong on 4/9/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController
@property User *user;
@property NSArray *arrayOfPosts;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;


@property Picture *scrollToPost;

@end
