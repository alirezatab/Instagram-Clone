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
}

@end
