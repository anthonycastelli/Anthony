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
    
    [self animateView:self.timeline toPoint:CGPointMake(160, 30) withDelay:0.3];
    [self animateView:self.backButton toPoint:CGPointMake(30, 30) withDelay:0.35];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    
    [self animateView:self.backButton toPoint:CGPointMake(350, 30) withDelay:0.0];
    [self animateView:self.timeline toPoint:CGPointMake(480, 30) withDelay:0.03];
    
    [self performBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    } afterDelay:0.3];
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
    
    
    
    [cell.background setImage:[UIImage imageNamed:@"timelines_background"]];
    [cell bounceImage:cell.background InToPoint:CGPointMake(160, 1338) withDelay:0.4];
    
    [cell.dimonds setImage:[UIImage imageNamed:@"timelines_dimonds"]];
    [cell bounceImage:cell.dimonds InToPoint:CGPointMake(160, 1338) withDelay:0.45];
    
    [cell.types setImage:[UIImage imageNamed:@"timelines_types"]];
    [cell bounceImage:cell.types InToPoint:CGPointMake(160, 1338) withDelay:0.50];
    
    [cell.lines setImage:[UIImage imageNamed:@"timelines_lines"]];
    [cell bounceImage:cell.lines InToPoint:CGPointMake(160, 1338) withDelay:0.55];
    
    [cell.info setImage:[UIImage imageNamed:@"timelines_info"]];
    [cell bounceImage:cell.info InToPoint:CGPointMake(160, 1338) withDelay:0.60];
}

@end
