//
//  CameraVC.m
//  Instagram
//
//  Created by ALIREZA TABRIZI on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//
////////////////////////////////
///com.EricDHong.Instagram//////
////////////////////////////////

#import "CameraVC.h"
#import "SharePhotoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "LibraryCollectionViewCell.h"
#import <Photos/Photos.h>
#import "CustomImageFlowLayout.h"

@interface CameraVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *pictureSegmentedControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedLibraryCellImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic, strong) PHFetchResult *assetsFetchResults;
@property(nonatomic, strong) PHCachingImageManager *imageManager;

@property NSMutableArray *arrayOfImagesInPhotoLibrary;
@property NSMutableArray *collector;
@property UIImage *snappedCameraImage;
@property UIImage *snappedCameraImageFlipped;

@end

@implementation CameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.collectionViewLayout = [[CustomImageFlowLayout alloc] init];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Fetch all assets, sorted by date created.
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    
    self.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    self.imageManager = [[PHCachingImageManager alloc] init];
    
    self.tabBarController.delegate = self;
    self.navigationController.navigationBarHidden = NO;
    
    [self.collectionView reloadData];
    
    [self noCameraInDevice];
    //[self turnCameraOn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.pictureSegmentedControl setSelectedSegmentIndex:0];
    self.allPhotos.hidden = YES;
}

// show error if no camera
-(void)noCameraInDevice{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // disable camera + video buttons
        [self.pictureSegmentedControl setEnabled:NO forSegmentAtIndex:1];
        [self.pictureSegmentedControl setEnabled:NO forSegmentAtIndex:2];
        
        // uialert
        UIAlertController *noCameraAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Device has no Camera" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *oKButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){}];
        [noCameraAlert addAction:oKButton];
        [self presentViewController:noCameraAlert animated:YES completion:nil];
    }
}

-(void)turnCameraOn {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraCaptureMode = UIImagePickerControllerCameraDeviceRear;
    //  show navagation bar so we can put an x to cancel
    picker.navigationBarHidden = NO;
    //  have a toolbar show up in the below so we can add additional buttons
    picker.toolbarHidden = YES;
    //  picker.wantsFullScreenLayout = YES;
    picker.delegate = self;
    //  crop boz arund the image after its taken
    picker.allowsEditing = YES;
    //  make all the camera controls appear or disappear
    picker.showsCameraControls = YES;

    [self presentViewController:picker animated:YES completion:NULL];
}

// set up camera
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (self.tabBarController.tabBar.selectedItem.tag == 2) {
        //[self turnCameraOn];
    }
}

#pragma mark - Camera delegates
// fired when we take picture
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector((_cmd)));

    NSString *mediaType = info[UIImagePickerControllerMediaType];
    //retrieve the actual UIImage when the picture is captures
    self.snappedCameraImageFlipped = info[UIImagePickerControllerOriginalImage];
    //flips the picture to have right oriantation
    
    self.snappedCameraImage = [self squareImageWithImage:self.snappedCameraImageFlipped scaledToSize:CGSizeMake(200, 200)];
    
    //NSLog(@"Media Type:   \"%@\"", mediaType);
    //NSLog(@"kUTTypeImage: \"%@\"", (NSString *)kUTTypeImage);
    //NSLog(@"Media Info %@: ", info);
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *photoTaken = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //save photo to library if it wasn't already saved... just been taken
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(photoTaken, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }
    [picker dismissViewControllerAnimated:YES completion: NULL];
}
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector((_cmd)));

    if (!error) {
        [self performSegueWithIdentifier:@"CameraPictureToShare" sender:self];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                       message:[error localizedDescription]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action){}];
        
        [alert addAction:okButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector((_cmd)));
    
    self.tabBarController.tabBar.hidden = NO;
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma fixing orientation of photo and scale
- (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    double ratio;
    double delta;
    CGPoint offset;
    
    //make a new square size, that is the resized imaged width
    CGSize sz = CGSizeMake(newSize.width, newSize.width);
    
    //figure out if the picture is landscape or portrait, then
    //calculate scale factor and offset
    if (image.size.width > image.size.height) {
        ratio = newSize.width / image.size.width;
        delta = (ratio*image.size.width - ratio*image.size.height);
        offset = CGPointMake(delta/2, 0);
    } else {
        ratio = newSize.width / image.size.height;
        delta = (ratio*image.size.height - ratio*image.size.width);
        offset = CGPointMake(0, delta/2);
    }
    
    //make the final clipping rect based on the calculated values
    CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                 (ratio * image.size.width) + delta,
                                 (ratio * image.size.height) + delta);
    
    //start a new context, with scale factor 0.0 so retina displays get
    //high quality image
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(sz, YES, 0.0);
    } else {
        UIGraphicsBeginImageContext(sz);
    }
    UIRectClip(clipRect);
    [image drawInRect:clipRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Library
//-(IBAction)onLibraryButtonPressed:(UIButton *)sender {
//    self.allPhotos.hidden = NO;
//    self.imageView.hidden = YES;
//    self.takePhotoButton.hidden = YES;
//}

-(IBAction)allPhotos:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)photosSegmentedControlerPressed:(UISegmentedControl *)sender {
    if (self.pictureSegmentedControl.selectedSegmentIndex == 0) {
        self.allPhotos.hidden = NO;
        self.collectionView.hidden =NO;
    } else if (self.pictureSegmentedControl.selectedSegmentIndex == 1){
        [self turnCameraOn];
        self.allPhotos.hidden = YES;
        self.collectionView.hidden =NO;
    }
}

#pragma mark - collectionView methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSLog(@"%lu", self.assetsFetchResults.count);
    return self.assetsFetchResults.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    //UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    
    [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info)
     {
         cell.libraryImageView.image = result;
     }];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    
    [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage *result, NSDictionary *info)
     {
         self.selectedLibraryCellImageView.image = [self squareImageWithImage:result scaledToSize:CGSizeMake(200, 200)];
         //self.selectedLibraryCellImageView.image = result;
     }];
}
#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"[%@ %@] ->%@", self.class, NSStringFromSelector((_cmd)), segue.identifier);
    if ([segue.identifier isEqualToString:@"CameraPictureToShare"]) {
        SharePhotoViewController *desVC = segue.destinationViewController;
        desVC.shareImage = self.snappedCameraImage;
        //desVC.backgroundImageView = self.choosenImage;
    } else if ([segue.identifier isEqualToString:@"SelectedLibraryPhoto"]){
        SharePhotoViewController *desVC = segue.destinationViewController;
        desVC.shareImage = self.selectedLibraryCellImageView.image;
    }
}
@end

//  overlay on top of camera lens view
//  UIImageView *cameraOverlayView = [UIImageView alloc]initWithImage:[UIImage imageNamed:@"cameraOverlay.png"];
//  cameraOverlayView.alpha = 0.0f;

//-(CGSize)collectionView:(UICollectionView *)collectionView layout: (UICollectionView *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    return CGSizeMake(self.collectionView.frame.size.width / 5, self.collectionView.frame.size.height / 2.5);
//}
