//
//  Picture+CoreDataProperties.h
//  Instagram
//
//  Created by Christopher Serra on 4/9/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Picture.h"

NS_ASSUME_NONNULL_BEGIN

@interface Picture (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *comments;
@property (nullable, nonatomic, retain) NSSet<User *> *likedBy;
@property (nullable, nonatomic, retain) User *owner;

@end

@interface Picture (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(NSManagedObject *)value;
- (void)removeCommentsObject:(NSManagedObject *)value;
- (void)addComments:(NSSet<NSManagedObject *> *)values;
- (void)removeComments:(NSSet<NSManagedObject *> *)values;

- (void)addLikedByObject:(User *)value;
- (void)removeLikedByObject:(User *)value;
- (void)addLikedBy:(NSSet<User *> *)values;
- (void)removeLikedBy:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
