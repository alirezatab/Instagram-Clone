//
//  PostDetailViewController.m
//  Instagram
//
//  Created by Eric Hong on 4/10/16.
//  Copyright © 2016 EricDHong. All rights reserved.
//

#import "PostDetailViewController.h"

@interface PostDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation PostDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"[%@ %@]", self.class, NSStringFromSelector(_cmd));
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = @"Hello, World";
    
    return cell;
}

- (IBAction)onBackButtonPressed:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
