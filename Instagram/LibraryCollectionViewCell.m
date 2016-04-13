//
//  LibraryCollectionViewCell.m
//  Instagram
//
//  Created by ALIREZA TABRIZI on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "LibraryCollectionViewCell.h"

@implementation LibraryCollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.libraryImageView.image = nil;
}

@end
