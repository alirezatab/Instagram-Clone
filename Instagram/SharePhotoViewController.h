//
//  SharePhotoViewController.h
//  Instagram
//
//  Created by ALIREZA TABRIZI on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharePhotoViewController : UIViewController

@property UIImage *shareImage;
@property (weak, nonatomic) IBOutlet UIImageView *toBeSharedImageView;

@end
