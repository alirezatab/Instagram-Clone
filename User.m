//
//  User.m
//  Instagram
//
//  Created by Christopher Serra on 4/12/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "User.h"
#import "Comment.h"
#import "Picture.h"
#import <UIKit/UIKit.h>

@implementation User

- (UIImage *)getHeartIcon:(Picture *)p {
    NSString *heartIconName = ([p isLikedBy:self]) ? (@"button-heart-on") : (@"button-heart-off");
    return [UIImage imageNamed:heartIconName];
}

@end
