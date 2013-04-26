//
//  ACWeatherViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/25/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACWeatherViewController.h"
#import "ACCurrentCell.h"
#import "ACForecastCell.h"

@interface ACWeatherViewController ()
- (void)animateView:(UIView *)view toPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;
- (void)configureCurrentCell:(ACCurrentCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)configureForecastCell:(ACForecastCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation ACWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) return 120.0f;
    return 96.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ACCurrentCell *current = (ACCurrentCell *)[tableView dequeueReusableCellWithIdentifier:@"CurrentCell" forIndexPath:indexPath];
        [self configureCurrentCell:current atIndexPath:indexPath];
        return current;
    }
    ACForecastCell *forecast = (ACForecastCell *)[tableView dequeueReusableCellWithIdentifier:@"ForecastCell" forIndexPath:indexPath];
    [self configureForecastCell:forecast atIndexPath:indexPath];
    return forecast;
}

- (void)configureCurrentCell:(ACCurrentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)configureForecastCell:(ACForecastCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
