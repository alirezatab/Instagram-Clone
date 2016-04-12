//
//  CameraVC.h
//  Instagram
//
//  Created by ALIREZA TABRIZI on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraVC : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *allPhotos;
@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;


@property UIImage *choosenImage;

@end
