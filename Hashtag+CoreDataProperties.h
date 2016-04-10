//
//  Hashtag+CoreDataProperties.h
//  Instagram
//
//  Created by Christopher Serra on 4/9/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Hashtag.h"

NS_ASSUME_NONNULL_BEGIN

@interface Hashtag (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *tagtext;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *comments;

@end

@interface Hashtag (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(NSManagedObject *)value;
- (void)removeCommentsObject:(NSManagedObject *)value;
- (void)addComments:(NSSet<NSManagedObject *> *)values;
- (void)removeComments:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
