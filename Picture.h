//
//  Picture.h
//  Instagram
//
//  Created by Christopher Serra on 4/12/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, User;

NS_ASSUME_NONNULL_BEGIN

@interface Picture : NSManagedObject
-(BOOL)isLikedBy:(User *)user;
@end

NS_ASSUME_NONNULL_END

#import "Picture+CoreDataProperties.h"
