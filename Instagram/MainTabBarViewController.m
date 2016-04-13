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
#import "CoreDataManager.h"
#import "User.h"
#import "Comment.h"
#import "Picture.h"

@interface MainTabBarViewController () <UITabBarControllerDelegate>
@property NSManagedObjectContext *moc;
@property NSArray *users;
@end


@implementation MainTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"Welcome to Ourstagram");
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));

    // SQLite
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSLog(@"sqlite dir = \n%@", appDelegate.applicationDocumentsDirectory);

    // Core Data
    self.users = [CoreDataManager fetchUsers];
    for (User *u in self.users) {
        NSLog(@"%@: %i pics", u.username, u.pictures.count);
    }

    // start in Profile tab
    self.selectedIndex = 4;
    
    // tab bar icons
    for (int i = 0; i < 5; i++) {
        [self centerTabBarIcons:i];
    }
    
    // sets the highlight image color to white
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    //[[UITabBar appearance]setAlpha:0.25];
    
}

//  Centers the icon image of the icon at a specific index
-(void)centerTabBarIcons:(int)index
{
    UITabBarItem *barItem = [self.tabBar.items objectAtIndex:index];
    barItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
}

#pragma mark - Navigation
-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    ProfileViewController *dstVC = viewController;
    dstVC.user = self.users[0];
}


@end
