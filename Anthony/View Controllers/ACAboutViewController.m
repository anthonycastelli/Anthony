//
//  ACAboutViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACAboutViewController.h"

@interface ACAboutViewController ()
- (void)animateView:(UIView *)view toPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;
- (void)shakeView:(UIView *)view withDistance:(float)distance;
@end

@implementation ACAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup in background
    [self.background setImage:[[UIImage imageNamed:@"about_background"] stretchableImageWithLeftCapWidth:160 topCapHeight:54]];
    [self.background setContentMode:UIViewContentModeScaleToFill];
    
    // Animate the objects into place
    [self animateView:self.backButton toPoint:CGPointMake(30, 30) withDelay:0.35];
    [self animateView:self.textView toPoint:CGPointMake(160, 274) withDelay:0.4];
    [self animateView:self.emerys toPoint:CGPointMake(32, 516) withDelay:0.5];
    [self animateView:self.twitter toPoint:CGPointMake(96, 516) withDelay:0.55];
    [self animateView:self.adn toPoint:CGPointMake(160, 516) withDelay:0.6];
    [self animateView:self.dribbble toPoint:CGPointMake(224, 516) withDelay:0.65];
    [self animateView:self.github toPoint:CGPointMake(288, 516) withDelay:0.7];
    
    // Setup the swipe gesture
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipe];
    
    // About me text
	NSString *about = @"Anthony Castelli about string";
    NSDictionary *defaultAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.437 green:0.494 blue:0.609 alpha:1.000]};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:about attributes:defaultAttributes];
    [self.textView setAttributedText:attributedString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Options

- (IBAction)back:(id)sender {
    [self animateView:self.backButton toPoint:CGPointMake(350, 30) withDelay:0.3];
    [self animateView:self.textView toPoint:CGPointMake(460, 274) withDelay:0.25];
    [self animateView:self.emerys toPoint:CGPointMake(352, 516) withDelay:0.20];
    [self animateView:self.twitter toPoint:CGPointMake(416, 516) withDelay:0.15];
    [self animateView:self.adn toPoint:CGPointMake(480, 516) withDelay:0.10];
    [self animateView:self.dribbble toPoint:CGPointMake(544, 516) withDelay:0.05];
    [self animateView:self.github toPoint:CGPointMake(608, 516) withDelay:0.0];
    
    [self performBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    } afterDelay:0.3];
}

- (IBAction)emerys:(id)sender {
    [self shakeView:self.emerys withDistance:6.0f];
    [self openAction:ACAboutActionEmerys];
}

- (IBAction)twitter:(id)sender {
    [self shakeView:self.twitter withDistance:6.0f];
    [self openAction:ACAboutActionTwitter];
}

- (IBAction)adn:(id)sender {
    [self shakeView:self.adn withDistance:6.0f];
    [self openAction:ACAboutActionAppDotNet];
}

- (IBAction)dribbble:(id)sender {
    [self shakeView:self.dribbble withDistance:6.0f];
    [self openAction:ACAboutActionDribbble];
}

- (IBAction)github:(id)sender {
    [self shakeView:self.github withDistance:6.0f];
    [self openAction:ACAboutActionGitHub];
}

- (void)openAction:(ACAboutAction)action {
    
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

- (void)shakeView:(UIView *)view withDistance:(float)distance {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:2];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint: CGPointMake(view.center.x - distance, view.center.y)]];
    [animation setToValue:[NSValue valueWithCGPoint: CGPointMake(view.center.x + distance, view.center.y)]];
    [view.layer addAnimation:animation forKey:@"position"];
}

@end
