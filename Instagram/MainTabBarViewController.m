//
//  MainTabBarViewController.m
//  Instagram
//
//  Created by Christopher Serra on 4/11/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "Comment.h"
#import "Picture.h"



@interface MainTabBarViewController ()
@end


@implementation MainTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Welcome to Ourstagram");
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));

    // CoreData
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.moc = appDelegate.managedObjectContext;
    NSLog(@"sqlite dir = \n%@", appDelegate.applicationDocumentsDirectory);


    // core data - fetch (or create dummy data)
    self.users = [NSArray new];
    [self coreLoadUsers];
    if (self.users.count == 0) {
        NSLog(@"no users in CoreData - creating new user");
        [self dummyData];
    } else {
        NSLog(@"%i users loaded from CoreData", self.users.count);
    }
    for (User *u in self.users) {
        NSLog(@"%@ (%@): \"%@\" (%i pics)", u.username, u.fullname, u.bio, u.pictures.count);
    }

    // tab bar - start in Profile tab
    self.selectedIndex = 4;
    NSLog(@"selected tab = %lu", (unsigned long)self.selectedIndex);
    
//    Calls the centerTabBarIcons method for each tab bar item 
    for (int i = 0; i < 5; i++) {
        [self centerTabBarIcons:i];
    }
    
//    Sets the highlight image color to white
    [[UITabBar appearance]setTintColor:[UIColor blackColor]];
//    [[UITabBar appearance]setAlpha:0.25];
    
}

//  Centers the icon image of the icon at a specific index
-(void)centerTabBarIcons:(int)index
{
    UITabBarItem *barItem = [self.tabBar.items objectAtIndex:index];
    barItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
}


@end
