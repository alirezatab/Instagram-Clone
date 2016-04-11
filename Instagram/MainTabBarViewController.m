//
//  MainTabBarViewController.m
//  Instagram
//
//  Created by Christopher Serra on 4/11/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "MainTabBarViewController.h"


@interface MainTabBarViewController ()
@end


@implementation MainTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Welcome to Ourstagram");
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));


    // start in Profile tab
    self.selectedIndex = 4;
    NSLog(@"selected tab = %i", self.selectedIndex);
}
@end
