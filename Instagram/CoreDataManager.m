//
//  CoreDataManager.m
//  Instagram
//
//  Created by Christopher Serra on 4/12/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "User.h"
#import "Comment.h"
#import "Picture.h"

@interface CoreDataManager ()
@end


@implementation CoreDataManager
static NSManagedObjectContext *moc;

void initMoc(void) {
    if (!moc) {
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        moc = appDelegate.managedObjectContext;
    }
}

// getMyUser() - returns User object for current user
+ (User *)getUserZero {
    initMoc();

    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    
    // fetch user0
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSError *error;
    NSArray *allUsers = [moc executeFetchRequest:req error:&error];
    if (error) {
        NSLog(@"core load error: %@", error);
        return nil;
    }
    NSLog(@"core load ok: %lu items", allUsers.count);
    
    return allUsers[0];
}

+ (NSArray *)fetchUsers {
    initMoc();

    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSError *error;
    NSArray *users = [[moc executeFetchRequest:req error:&error] mutableCopy];
    if (!error) {
        NSLog(@"core load ok: %lu items", users.count);
    } else {
        NSLog(@"core load error: %@", error);
    }
    
    if (users.count == 0) { users = [CoreDataManager dummyData]; }

    return users;
}
+ (NSArray *)dummyData {
    initMoc();
    
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    
    // User
    User *u = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc];
    u.username = @"heisenberg0";
    u.fullname = @"Walter White";
    u.bio = @"I've still got things left to do";
    
    [CoreDataManager addPicture:[UIImage imageNamed:@"heisenberg-image1"] withComment:@"laundry day" fromUser:u];
    [CoreDataManager addPicture:[UIImage imageNamed:@"heisenberg-image2"] withComment:@"kicking it with Jesse" fromUser:u];
    [CoreDataManager save];
    
    NSArray *users = @[u];
    User *u2 = users[0];
    NSLog(@"user \"@%@\" has %i pictures", u2.username, u2.pictures.count);
    return users;
}

+ (Picture *)addPicture:(UIImage *)pictureImage withComment:(NSString *)commentStr fromUser:(User *)user {
    initMoc();
    
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));

    Comment *c = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:moc];
    c.text = commentStr;
    c.time = [NSDate date];
    c.user = user;
    
    Picture *p = [NSEntityDescription insertNewObjectForEntityForName:@"Picture" inManagedObjectContext:moc];
    p.image = UIImagePNGRepresentation(pictureImage);
    p.location = @"somewhere in the desert, New Mexico"; // TODO
    p.time = [NSDate date];
    p.owner = user;
    [p addCommentsObject:c];
    //[p addLikedByObject:user];

    // TODO: search for hashtags
    
    return p;
}

+ (void)save {
    initMoc();
    
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));

    // save to Core
    NSError *error;
    if ([moc save:&error]) {
        NSLog(@"core save ok");
    } else {
        NSLog(@"core save error: %@", error);
    }
}
@end
