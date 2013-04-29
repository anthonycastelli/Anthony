//
//  ACWWDCViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/28/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACWWDCViewController.h"

@interface ACWWDCViewController ()
- (void)animateView:(UIView *)view toPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;
@end

@implementation ACWWDCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup the swipe gesture
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipe];
    
    [self animateView:self.backButton toPoint:CGPointMake(30, 30) withDelay:0.3];
    [self animateView:self.wwdc toPoint:CGPointMake(160, 30) withDelay:0.34];
    [self animateView:self.textView toPoint:CGPointMake(160, 30) withDelay:0.36];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self animateView:self.backButton toPoint:CGPointMake(350, 30) withDelay:0.03];
    [self animateView:self.wwdc toPoint:CGPointMake(480, 30) withDelay:0.01];
    [self animateView:self.textView toPoint:CGPointMake(480, 0) withDelay:0.0];
    [self performBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    } afterDelay:0.02];
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
