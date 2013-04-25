//
//  ACAboutViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACAboutViewController.h"

@interface ACAboutViewController ()
- (void)shakeView:(UIView *)viewToShake;
@end

@implementation ACAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipe];
    
	NSString *about = @"Anthony Castelli about string";
    NSDictionary *defaultAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:about attributes:defaultAttributes];
    [self.textView setAttributedText:attributedString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Options

- (IBAction)back:(id)sender {
    [self shakeView:self.backButton];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)emerys:(id)sender {
    [self shakeView:self.emerys];
    [self openAction:ACAboutActionEmerys];
}

- (IBAction)twitter:(id)sender {
    [self shakeView:self.twitter];
    [self openAction:ACAboutActionTwitter];
}

- (IBAction)adn:(id)sender {
    [self shakeView:self.adn];
    [self openAction:ACAboutActionAppDotNet];
}

- (IBAction)dribbble:(id)sender {
    [self shakeView:self.dribbble];
    [self openAction:ACAboutActionDribbble];
}

- (IBAction)github:(id)sender {
    [self shakeView:self.github];
    [self openAction:ACAboutActionGitHub];
}

- (void)openAction:(ACAboutAction)action {
    
}

#pragma mark - Animations

- (void)shakeView:(UIView *)viewToShake {
    CGFloat t = 4.0;
    CGAffineTransform translateRight  = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
    
    viewToShake.transform = translateLeft;
    
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform = CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

@end
