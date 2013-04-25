//
//  ACTimelineViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACTimelineViewController.h"

@interface ACTimelineViewController ()
- (void)animateView:(UIView *)view toPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;
@end

@implementation ACTimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self animateView:self.backButton toPoint:CGPointMake(30, 30) withDelay:0.35];
    [self animateView:self.background toPoint:CGPointMake(160, 790) withDelay:0.4];
    [self animateView:self.dimonds toPoint:CGPointMake(160, 790) withDelay:0.45];
    [self animateView:self.types toPoint:CGPointMake(160, 790) withDelay:0.5];
    [self animateView:self.lines toPoint:CGPointMake(160, 790) withDelay:0.55];
    [self animateView:self.info toPoint:CGPointMake(160, 790) withDelay:0.6];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self animateView:self.backButton toPoint:CGPointMake(350, 30) withDelay:0.35];
    [self animateView:self.background toPoint:CGPointMake(480, 790) withDelay:0.20];
    [self animateView:self.dimonds toPoint:CGPointMake(480, 790) withDelay:0.15];
    [self animateView:self.types toPoint:CGPointMake(480, 790) withDelay:0.1];
    [self animateView:self.lines toPoint:CGPointMake(480, 790) withDelay:0.05];
    [self animateView:self.info toPoint:CGPointMake(480, 790) withDelay:0];
    
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

@end
