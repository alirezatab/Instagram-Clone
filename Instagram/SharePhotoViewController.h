//
//  SharePhotoViewController.h
//  Instagram
//
//  Created by ALIREZA TABRIZI on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharePhotoViewController : UIViewController <UITextViewDelegate>

@property UIImage *shareImage;
@property (weak, nonatomic) IBOutlet UIImageView *toBeSharedImageView;
@property (weak, nonatomic) IBOutlet UITextView *userCommentTextView;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
