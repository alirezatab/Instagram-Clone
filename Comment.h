//
//  Comment.h
//  Instagram
//
//  Created by Christopher Serra on 4/12/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hashtag, Picture, User;

NS_ASSUME_NONNULL_BEGIN

@interface Comment : NSManagedObject
-(NSString *)agoString;
@end

NS_ASSUME_NONNULL_END

#import "Comment+CoreDataProperties.h"
