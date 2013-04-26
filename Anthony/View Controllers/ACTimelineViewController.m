//
//  ACTimelineViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACTimelineViewController.h"
#import "ACTimelineCell.h"

@interface ACTimelineViewController ()
- (void)animateView:(UIView *)view toPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;
- (void)configureCell:(ACTimelineCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation ACTimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setBackgroundColor:[UIColor blackColor]];
    
    [self animateView:self.timeline toPoint:CGPointMake(160, 30) withDelay:0.4];
    [self animateView:self.backButton toPoint:CGPointMake(30, 30) withDelay:0.3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self animateView:self.backButton toPoint:CGPointMake(350, 30) withDelay:0.1];
    [self animateView:self.timeline toPoint:CGPointMake(480, 30) withDelay:0.0];
    
    
    ACTimelineCell *cell = (ACTimelineCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    [cell bounceImage:cell.background InToPoint:CGPointMake(480, 1338) withDelay:0.10];
    [cell bounceImage:cell.dimonds InToPoint:CGPointMake(480, 1338) withDelay:0.08];
    [cell bounceImage:cell.types InToPoint:CGPointMake(480, 1338) withDelay:0.06];
    [cell bounceImage:cell.lines InToPoint:CGPointMake(480, 1338) withDelay:0.04];
    [cell bounceImage:cell.info InToPoint:CGPointMake(480, 1338) withDelay:0.02];
    
    [self performBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    } afterDelay:0.07];
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

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 2675.5f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ACTimelineCell *cell = (ACTimelineCell *)[tableView dequeueReusableCellWithIdentifier:@"TimelineCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(ACTimelineCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor blackColor]];
    [cell.contentView setBackgroundColor:[UIColor blackColor]];
    
    
    [self performBlock:^{
        [cell.background setImage:[UIImage imageNamed:@"timelines_background"]];
        [cell bounceImage:cell.background InToPoint:CGPointMake(160, 1338) withDelay:0];
    } afterDelay:0.2];
    
    [self performBlock:^{
        [cell.dimonds setImage:[UIImage imageNamed:@"timelines_dimonds"]];
        [cell bounceImage:cell.dimonds InToPoint:CGPointMake(160, 1338) withDelay:0];
    } afterDelay:0.25];
    
    [self performBlock:^{
        [cell.types setImage:[UIImage imageNamed:@"timelines_types"]];
        [cell bounceImage:cell.types InToPoint:CGPointMake(160, 1338) withDelay:0];
    } afterDelay:0.3];
    
    [self performBlock:^{
        [cell.lines setImage:[UIImage imageNamed:@"timelines_lines"]];
        [cell bounceImage:cell.lines InToPoint:CGPointMake(160, 1338) withDelay:0];
    } afterDelay:0.35];
    
    [self performBlock:^{
        [cell.info setImage:[UIImage imageNamed:@"timelines_info"]];
        [cell bounceImage:cell.info InToPoint:CGPointMake(160, 1338) withDelay:0];
    } afterDelay:0.4];
}

@end
