//
//  User.h
//  Instagram
//
//  Created by Christopher Serra on 4/12/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Picture, UIImage;

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject
- (UIImage *)getHeartIcon:(Picture *)p;
@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
