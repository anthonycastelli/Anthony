//
//  ACViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACViewController.h"
#import "ACTableViewCell.h"
#import "ACAboutViewController.h"

#define aboutTime 0.2
#define timelineTime 0.25
#define appsTime 0.3
#define designTime 0.35
#define wwdcTime 0.4

@interface ACViewController ()
- (void)configureCell:(ACTableViewCell *)cell atIindexPath:(NSIndexPath *)indexPath;
@end

@implementation ACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Options

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 109.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ACTableViewCell *cell = (ACTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIindexPath:indexPath];
    return cell;
}

- (void)configureCell:(ACTableViewCell *)cell atIindexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [cell.imageLabel setImage:[UIImage imageNamed:@"about_button"]];
            [cell bounceImageInToPoint:CGPointMake(160, 0) withDelay:aboutTime];
            break;
        case 1:
            [cell.imageLabel setImage:[UIImage imageNamed:@"timeline_button"]];
            [cell bounceImageInToPoint:CGPointMake(160, 0) withDelay:timelineTime];
            break;
        case 2:
            [cell.imageLabel setImage:[UIImage imageNamed:@"apps_button"]];
            [cell bounceImageInToPoint:CGPointMake(160, 0) withDelay:appsTime];
            break;
        case 3:
            [cell.imageLabel setImage:[UIImage imageNamed:@"designs_button"]];
            [cell bounceImageInToPoint:CGPointMake(160, 0) withDelay:designTime];
            break;
        case 4:
            [cell.imageLabel setImage:[UIImage imageNamed:@"wwdc_button"]];
            [cell bounceImageInToPoint:CGPointMake(160, 0) withDelay:wwdcTime];
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controller = nil;
    switch (indexPath.row) {
        case 0:
            controller = [self.storyboard instantiateViewControllerWithIdentifier:@"About"];
            break;
        case 1:
            controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Timeline"];
            break;
        case 2:
            controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Apps"];
            break;
        case 3:
            controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Designs"];
            break;
        case 4:
            controller = [self.storyboard instantiateViewControllerWithIdentifier:@"WWDC"];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
}

@end
