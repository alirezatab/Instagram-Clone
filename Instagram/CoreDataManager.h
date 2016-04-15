//
//  CoreDataManager.h
//  Instagram
//
//  Created by Christopher Serra on 4/12/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Picture.h"
#import "Hashtag.h"


@interface CoreDataManager : NSObject
+ (Picture *)addPicture:(UIImage *)pictureImage
            withComment:(NSString *)commentStr
               fromUser:(User *)user;
+ (void)deleteObject:(NSManagedObject *)x;
+ (void)save;
+ (NSArray *)fetchComments;
+ (NSArray *)fetchUsers;
+ (Hashtag *)fetchHashtag:(NSString *)tag;
+ (User *)getUserZero;
@end
