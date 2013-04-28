//
//  ACFlashlightViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACFlashlightViewController.h"
#import "ACTorch.h"

@interface ACFlashlightViewController ()
- (void)animateView:(UIView *)view toPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;
@end

@implementation ACFlashlightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self animateView:self.backButton toPoint:CGPointMake(30, 30) withDelay:0.3];
    [self animateView:self.flashlight toPoint:CGPointMake(160, 30) withDelay:0.35];
    [self animateView:self.torchRingOne toPoint:CGPointMake(160, 274) withDelay:0.4];
    [self animateView:self.torchRingThree toPoint:CGPointMake(160, 274) withDelay:0.45];
    [self animateView:self.torchButton toPoint:CGPointMake(160, 274) withDelay:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self animateView:self.flashlight toPoint:CGPointMake(480, 30) withDelay:0.0];
    [self animateView:self.backButton toPoint:CGPointMake(350, 30) withDelay:0.03];
    [self animateView:self.torchRingOne toPoint:CGPointMake(400, 274) withDelay:0.05];
    [self animateView:self.torchRingThree toPoint:CGPointMake(400, 274) withDelay:0.07];
    [self animateView:self.torchButton toPoint:CGPointMake(400, 274) withDelay:0.09];
    
    [self performBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    } afterDelay:0.06];
    
    [[ACTorch sharedTorch] stop]; // Make sure the torch is off
}

- (IBAction)torch:(id)sender {
    ACTorch *torch = [ACTorch sharedTorch];
    if ([torch isTorchOn]) {
        [torch stop];
        [self.torchButton setBackgroundImage:[UIImage imageNamed:@"flashlight_torch_button_off"] forState:UIControlStateNormal];
    } else {
        [torch start];
        [self.torchButton setBackgroundImage:[UIImage imageNamed:@"flashlight_torch_button_on"] forState:UIControlStateNormal];
    }
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
