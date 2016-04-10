//
//  User+CoreDataProperties.h
//  Instagram
//
//  Created by Christopher Serra on 4/9/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSString *fullname;
@property (nullable, nonatomic, retain) NSString *bio;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *pictures;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *comments;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *likes;
@property (nullable, nonatomic, retain) NSSet<User *> *followedBy;
@property (nullable, nonatomic, retain) NSSet<User *> *following;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPicturesObject:(NSManagedObject *)value;
- (void)removePicturesObject:(NSManagedObject *)value;
- (void)addPictures:(NSSet<NSManagedObject *> *)values;
- (void)removePictures:(NSSet<NSManagedObject *> *)values;

- (void)addCommentsObject:(NSManagedObject *)value;
- (void)removeCommentsObject:(NSManagedObject *)value;
- (void)addComments:(NSSet<NSManagedObject *> *)values;
- (void)removeComments:(NSSet<NSManagedObject *> *)values;

- (void)addLikesObject:(NSManagedObject *)value;
- (void)removeLikesObject:(NSManagedObject *)value;
- (void)addLikes:(NSSet<NSManagedObject *> *)values;
- (void)removeLikes:(NSSet<NSManagedObject *> *)values;

- (void)addFollowedByObject:(User *)value;
- (void)removeFollowedByObject:(User *)value;
- (void)addFollowedBy:(NSSet<User *> *)values;
- (void)removeFollowedBy:(NSSet<User *> *)values;

- (void)addFollowingObject:(User *)value;
- (void)removeFollowingObject:(User *)value;
- (void)addFollowing:(NSSet<User *> *)values;
- (void)removeFollowing:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
