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

@interface MainTabBarViewController () <UITabBarControllerDelegate>
@property NSManagedObjectContext *moc;
@property NSArray *users;
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

#pragma mark - Navigation
-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    ProfileViewController *dstVC = viewController;
    dstVC.user = self.users[0];
}



#pragma mark - CoreData
-(void)dummyData {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));

    // User
    User *u = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.moc];
    u.username = @"heisenberg0";
    u.fullname = @"Walter White";
    u.bio = @"I've still got things left to do";

    [self coreAddPicture:[UIImage imageNamed:@"heisenberg-image1"] withComment:@"laundry day" fromUser:u];
    [self coreAddPicture:[UIImage imageNamed:@"heisenberg-image2"] withComment:@"kicking it with Jesse" fromUser:u];
    [self coreSave];
    
    self.users = @[u];
    
    // confirm that self.users[] got populated
    User *u2 = self.users[0];
    NSLog(@"user \"@%@\" has %i pictures", u2.username, u2.pictures.count);
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
    [p addLikedByObject:user];
}
-(void)coreLoadUsers {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    //req.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES]];
    //    r.predicate = [NSPredicate predicateWithFormat:@"age >= 60 and budget >= 250"];
    
    NSError *error;
    self.users = [[self.moc executeFetchRequest:req error:&error] mutableCopy];
    if (!error) {
        NSLog(@"core load ok: %lu items", self.users.count);
    } else {
        NSLog(@"core load error: %@", error);
    }
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
