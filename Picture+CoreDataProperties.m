//
//  Picture+CoreDataProperties.m
//  Instagram
//
//  Created by Christopher Serra on 4/12/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Picture+CoreDataProperties.h"

@implementation Picture (CoreDataProperties)

@dynamic image;
@dynamic location;
@dynamic time;
@dynamic comments;
@dynamic likedBy;
@dynamic owner;

@end
