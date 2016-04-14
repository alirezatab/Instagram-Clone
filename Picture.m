//
//  Picture.m
//  Instagram
//
//  Created by Christopher Serra on 4/12/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "Picture.h"
#import "Comment.h"
#import "User.h"

@implementation Picture

-(BOOL)isLikedBy:(User *)user {
    return [self.likedBy containsObject:user];
}

@end
