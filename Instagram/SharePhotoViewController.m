//
//  SharePhotoViewController.m
//  Instagram
//
//  Created by ALIREZA TABRIZI on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "SharePhotoViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "Comment.h"
#import "Picture.h"


@interface SharePhotoViewController ()
@property NSManagedObjectContext *moc;
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
    
    // CoreData
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.moc = appDelegate.managedObjectContext;
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
    NSLog(@"Share Button Pressed");

    // user: getMyUser()
    // image: self.shareImage
    // comment: self.userCommentTextView.text
    [self coreAddPicture:self.shareImage withComment:self.userCommentTextView.text fromUser:[self getMyUser]];
    [self coreSave];
}

-(void)coreAddPicture:(UIImage *)pictureImg withComment:(NSString *)commentStr fromUser:(User *)user {
    Comment *c = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.moc];
    c.text = commentStr;
    c.time = [NSDate date];
    c.user = user;
    
    Picture *p = [NSEntityDescription insertNewObjectForEntityForName:@"Picture" inManagedObjectContext:self.moc];
    p.image = UIImagePNGRepresentation(pictureImg);
    p.location = @"somewhere in the desert, New Mexico";
    p.time = [NSDate date];
    p.owner = user;
    [p addCommentsObject:c];
    //[p addLikedByObject:user];
}

// getMyUser() - returns User object for current user
-(User *)getMyUser {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    
    if (! self.moc) {
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        self.moc = appDelegate.managedObjectContext;
    }

    // fetch user0
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSError *error;
    NSArray *allUsers = [self.moc executeFetchRequest:req error:&error];
    if (error) {
        NSLog(@"core load error: %@", error);
        return nil;
    }
    NSLog(@"core load ok: %lu items", allUsers.count);
    
    return allUsers[0];
}
-(void)coreSave {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    // save to Core
    NSError *error;
    if ([self.moc save:&error]) {
        NSLog(@"core save ok");
    } else {
        NSLog(@"core save error: %@", error);
    }
}


@end
