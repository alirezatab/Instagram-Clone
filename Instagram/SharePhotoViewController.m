//
//  SharePhotoViewController.m
//  Instagram
//
//  Created by ALIREZA TABRIZI on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "SharePhotoViewController.h"

@interface SharePhotoViewController ()

@end

@implementation SharePhotoViewController

- (void)viewDidLoad {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector((_cmd)));
    [super viewDidLoad];
    self.toBeSharedImageView.image = self.shareImage;
   // self.backgroundImageView.image = self.shareImage;
    self.userCommentTextView.text = @"Write a caption...";
    self.userCommentTextView.textColor = [UIColor lightGrayColor];
    self.userCommentTextView.delegate = self;
    self.okButton.hidden = YES;
    self.okButton.enabled = NO;
    
    //self.tabBarController.tabBar.hidden = YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([self.userCommentTextView.text containsString:@"Write a caption..."]) {
    self.userCommentTextView.text = @"";
    self.userCommentTextView.textColor = [UIColor blackColor];
    self.okButton.hidden = NO;
    self.okButton.enabled = YES;
    } else {
        [self.userCommentTextView.text stringByAppendingString:self.userCommentTextView.text];
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    if (self.userCommentTextView.text.length == 0) {
        self.userCommentTextView.textColor = [UIColor lightGrayColor];
        self.userCommentTextView.text = @"Write a caption...";
        [self.userCommentTextView resignFirstResponder];
    }
}
- (IBAction)onOKButtonPressed:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.userCommentTextView.text.length == 0) {
        self.userCommentTextView.textColor = [UIColor lightGrayColor];
        self.userCommentTextView.text = @"Write a caption...";
        [self.view endEditing:YES];
    }
}

- (IBAction)onShareButtonPressed:(UIButton *)sender {
    NSLog(@"Share Button Pressed");
}


@end
