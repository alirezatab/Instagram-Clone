//
//  User+CoreDataProperties.h
//  Instagram
//
//  Created by Christopher Serra on 4/12/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *bio;
@property (nullable, nonatomic, retain) NSString *fullname;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSSet<Comment *> *comments;
@property (nullable, nonatomic, retain) NSSet<User *> *followedBy;
@property (nullable, nonatomic, retain) NSSet<User *> *following;
@property (nullable, nonatomic, retain) NSSet<Picture *> *likes;
@property (nullable, nonatomic, retain) NSSet<Picture *> *pictures;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet<Comment *> *)values;
- (void)removeComments:(NSSet<Comment *> *)values;

- (void)addFollowedByObject:(User *)value;
- (void)removeFollowedByObject:(User *)value;
- (void)addFollowedBy:(NSSet<User *> *)values;
- (void)removeFollowedBy:(NSSet<User *> *)values;

- (void)addFollowingObject:(User *)value;
- (void)removeFollowingObject:(User *)value;
- (void)addFollowing:(NSSet<User *> *)values;
- (void)removeFollowing:(NSSet<User *> *)values;

- (void)addLikesObject:(Picture *)value;
- (void)removeLikesObject:(Picture *)value;
- (void)addLikes:(NSSet<Picture *> *)values;
- (void)removeLikes:(NSSet<Picture *> *)values;

- (void)addPicturesObject:(Picture *)value;
- (void)removePicturesObject:(Picture *)value;
- (void)addPictures:(NSSet<Picture *> *)values;
- (void)removePictures:(NSSet<Picture *> *)values;

@end

NS_ASSUME_NONNULL_END
