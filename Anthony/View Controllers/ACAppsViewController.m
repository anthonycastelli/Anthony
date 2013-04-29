//
//  ACAppsViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/25/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACAppsViewController.h"
#import "ACTableViewCell.h"

@interface ACAppsViewController ()
- (void)animateView:(UIView *)view toPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;
@end

@implementation ACAppsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup the swipe gesture
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self animateView:self.backButton toPoint:CGPointMake(30, 30) withDelay:0.3];
    [self animateView:self.apps toPoint:CGPointMake(160, 30) withDelay:0.4];
    [self.tableView reloadData];
}

- (IBAction)back:(id)sender {
    [self animateView:self.backButton toPoint:CGPointMake(350, 30) withDelay:0.1];
    [self animateView:self.apps toPoint:CGPointMake(480, 30) withDelay:0.0];
    
    ACTableViewCell *weatherCell = (ACTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [weatherCell bounceImageInToPoint:CGPointMake(480, 0) withDelay:0.0];
    
    ACTableViewCell *flashlightCell = (ACTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [flashlightCell bounceImageInToPoint:CGPointMake(480, 0) withDelay:0.05];
    
    [self performBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    } afterDelay:0.1];
}

#pragma mark - Animations

- (void)animateView:(UIView *)view toPoint:(CGPoint)point withDelay:(NSTimeInterval)delay {
    [self performBlock:^{
        NSString *keyPath = @"position.x";
        id toValue = [NSNumber numberWithFloat:point.x];
        ACBounceAnimation *bounce = [ACBounceAnimation animationWithKeyPath:keyPath];
        bounce.fromValue = [NSNumber numberWithFloat:view.center.x];
        bounce.toValue = toValue;
        bounce.duration = 0.6f;
        bounce.numberOfBounces = 4;
        bounce.shouldOvershoot = YES;
        
        [view.layer addAnimation:bounce forKey:@"bounce"];
        [view.layer setValue:toValue forKeyPath:keyPath];
    } afterDelay:delay];
}

#pragma mark - Options

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
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
            [cell.imageLabel setImage:[UIImage imageNamed:@"apps_weather"]];
            [cell bounceImageInToPoint:CGPointMake(160, 0) withDelay:0.2];
            break;
        case 1:
            [cell.imageLabel setImage:[UIImage imageNamed:@"apps_flashlight"]];
            [cell bounceImageInToPoint:CGPointMake(160, 0) withDelay:0.25];
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controller = nil;
    switch (indexPath.row) {
        case 0:
            controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Weather"];
            break;
        case 1:
            controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Flashlight"];
            break;
        default:
            break;
    }
    
    ACTableViewCell *aboutCell = (ACTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [aboutCell bounceImageInToPoint:CGPointMake(-160, 0) withDelay:0.05];
    
    ACTableViewCell *timelineCell = (ACTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [timelineCell bounceImageInToPoint:CGPointMake(-160, 0) withDelay:0.1];
    
    [self animateView:self.backButton toPoint:CGPointMake(-50, 30) withDelay:0.0];
    [self animateView:self.apps toPoint:CGPointMake(-160, 30) withDelay:0.0];
    
    [self performBlock:^{
        [self.navigationController pushViewController:controller animated:YES];
    } afterDelay:0.1];
}

@end
