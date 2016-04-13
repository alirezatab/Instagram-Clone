//
//  MainTabBarViewController.m
//  Instagram
//
//  Created by Christopher Serra on 4/11/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "MainTabBarViewController.h"



@interface MainTabBarViewController ()

@property NSArray *arrayOfTabBarIcons;

@end


@implementation MainTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Welcome to Ourstagram");
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    
    _arrayOfTabBarIcons = @[[UIImage imageNamed:@"Home-40"],
                            [UIImage imageNamed:@"Search-40"],
                            [UIImage imageNamed:@"Compact Camera-40"],
                            [UIImage imageNamed:@"Wedding Photo-40"],
                            [UIImage imageNamed:@"User-40"]];


    // start in Profile tab
    self.selectedIndex = 4;
    NSLog(@"selected tab = %lu", (unsigned long)self.selectedIndex);
    
//    Calls the centerTabBarIcons method for each tab bar item 
    for (int i = 0; i < 5; i++) {
        [self centerTabBarIcons:i];
    }
    
//    Sets the highlight image color to white
    [[UITabBar appearance]setTintColor:[UIColor blackColor]];
    [[UITabBar appearance]setAlpha:0.25];
    
    
    
}

//  Centers the icon image of the icon at a specific index
-(void)centerTabBarIcons:(int)index
{
    UITabBarItem *barItem = [self.tabBar.items objectAtIndex:index];
    barItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    barItem.image = _arrayOfTabBarIcons[index];
    barItem.title = nil;
    
    
}


@end
