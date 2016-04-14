//
//  SharePhotoViewController.m
//  Instagram
//
//  Created by ALIREZA TABRIZI on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "SharePhotoViewController.h"
#import "User.h"
#import "Comment.h"
#import "Picture.h"
#import "CoreDataManager.h"

@interface SharePhotoViewController ()
@end

@implementation SharePhotoViewController
- (void)viewDidLoad {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector((_cmd)));
    [super viewDidLoad];

    self.toBeSharedImageView.image = self.shareImage;
    self.userCommentTextView.text = @"Write a caption...";
    self.userCommentTextView.textColor = [UIColor lightGrayColor];
    self.userCommentTextView.delegate = self;
    self.okButton.hidden = YES;
    self.okButton.enabled = NO;
    
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
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
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));

    // user: getMyUser()
    // image: self.shareImage
    // comment: self.userCommentTextView.text
    
    if ([self.userCommentTextView.text containsString:@"Write a caption..."]) {
        self.userCommentTextView.text = @"";
    }
    
    [CoreDataManager addPicture:self.shareImage withComment:self.userCommentTextView.text fromUser:[self getMyUser]];
    [CoreDataManager save];
}

-(void)viewDidDisappear:(BOOL)animated{
    // insert back into onShareButtonPressed if need the pop feature for to cameraVC
    // locally store the navigation controller since
    // self.navigationController will be nil once we are popped
    UINavigationController *navController = self.navigationController;
    
    //Pop this controller and replace with another
    [navController popViewControllerAnimated:NO];
    // [navController pushViewController:someViewController animated:NO];
}

// getMyUser() - returns User object for current user
// TODO: this should come from parent VC instead (?)
-(User *)getMyUser {
    return [CoreDataManager getUserZero];
}
@end


