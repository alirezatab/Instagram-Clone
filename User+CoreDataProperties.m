//
//  User+CoreDataProperties.m
//  Instagram
//
//  Created by Christopher Serra on 4/9/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

@dynamic username;
@dynamic fullname;
@dynamic bio;
@dynamic pictures;
@dynamic comments;
@dynamic likes;
@dynamic followedBy;
@dynamic following;

@end
