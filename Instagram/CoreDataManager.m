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



#pragma mark - primitive

void initMoc(void) {
    if (!moc) {
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        moc = appDelegate.managedObjectContext;
    }
}

+ (void)save {
    initMoc();
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    NSError *error;
    if ([moc save:&error]) {
//        NSLog(@"core save ok");
    } else {
        NSLog(@">>> core save error: %@", error);
    }
}

+ (void)deleteObject:(NSManagedObject *)x {
    initMoc();
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    [moc deleteObject:x];
}

+ (NSArray *)fetchAllOfType:(NSString *)entityType {
    initMoc();
    NSLog(@"[%@ %@]: %@", self.class, NSStringFromSelector(_cmd), entityType);
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:entityType];
    NSError *error;
    NSArray *fetchedObjects = [moc executeFetchRequest:req error:&error];
    if (!error) {
        NSLog(@"core load ok: %lu %@s", fetchedObjects.count, entityType);
    } else {
        NSLog(@"core load error: %@", error);
    }
    return fetchedObjects;
}


#pragma mark - Comments
+ (NSArray *)fetchComments {
    return [self fetchAllOfType:@"Comment"];
}


#pragma mark - Users
+ (NSArray *)fetchUsers {
    NSArray *users = [self fetchAllOfType:@"User"];
    if (users.count == 0) { users = [CoreDataManager dummyData]; }
    return users;
}
+ (User *)getUserZero {
    return [self fetchUsers][0];
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
    NSLog(@"user \"@%@\" has %lu pictures", u2.username, u2.pictures.count);
    return users;
}


#pragma mark - Pictures
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

@end
