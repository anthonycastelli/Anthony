//
//  ACAboutViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACAboutViewController.h"

@interface ACAboutViewController ()
@property (nonatomic, retain) ACAlertView *emerysAlert;
@property (nonatomic, retain) ACAlertView *twitterAlert;
@property (nonatomic, retain) ACAlertView *appnetAlert;
@property (nonatomic, retain) ACAlertView *dribbbleAlert;
@property (nonatomic, retain) ACAlertView *githubAlert;

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
    NSString *name = @"Anthony";
    NSDictionary *defaultAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.437 green:0.494 blue:0.609 alpha:1.000],
                                        NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0]};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:about attributes:defaultAttributes];
    
    NSDictionary *nameAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.437 green:0.494 blue:0.609 alpha:1.000],
                                        NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0]};
    [attributedString setAttributes:nameAttributes range:[about rangeOfString:name]];
    
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
    
    switch (action) {
        case ACAboutActionEmerys:
            self.emerysAlert = [[ACAlertView alloc] initWithTitle:@"Emerys"
                                                          message:@"Emerys is my company I founded Christmas Eve 2012. Click okay to visit the website and see what apps I have released or whats coming soon."
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Okay", nil];
            [self.emerysAlert show];
            break;
        case ACAboutActionTwitter:
            self.twitterAlert = [[ACAlertView alloc] initWithTitle:@"Twitter"
                                                           message:@"Clicking okay will take you to Twitter.com/neueanthony where you can see what im tweeting about. Would you like to continue?"
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:@"Okay", nil];
            [self.twitterAlert show];
            break;
        case ACAboutActionAppDotNet:
            self.appnetAlert = [[ACAlertView alloc] initWithTitle:@"App.net"
                                                          message:@"Clicking okay will take you to alpha.app.net/amc where you can see what im posting about. Would you like to continue?"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Okay", nil];
            [self.appnetAlert show];
            break;
        case ACAboutActionDribbble:
            self.dribbbleAlert = [[ACAlertView alloc] initWithTitle:@"Dribbble"
                                                            message:@"Clicking okay will take you to dribbble.com/amc where you can see my lastest work. Would you like to take a look?"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Okay", nil];
            [self.dribbbleAlert show];
            break;
        case ACAboutActionGitHub:
            self.githubAlert = [[ACAlertView alloc] initWithTitle:@"GitHub"
                                                          message:@"Clicking okay will take you to GitHub.com/anthonycastelli where you can see what projects I have contributed to or what I have open sourced. Would you like to continue?"
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Okay", nil];
            [self.githubAlert show];
            break;
        default:
            break;
    }
}

#pragma mark - ACAlertView Delegate

- (void)alertView:(ACAlertView *)alertView tappedButtonAtIndex:(NSInteger)index {
    [ACAlertView setGlobalAcceptButtonDismissalAnimationStyle:ACAlertViewDismissalStyleFall];
    [ACAlertView setGlobalCancelButtonDismissalAnimationStyle:ACAlertViewDismissalStyleFall];
    if (alertView == self.emerysAlert) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://emerys.co/"]];
    if (alertView == self.twitterAlert) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/neueanthony"]];
    if (alertView == self.appnetAlert) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://alpha.app.net/amc"]];
    if (alertView == self.dribbbleAlert) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://dribbble.com/amc"]];
    if (alertView == self.githubAlert) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://github.com/anthonycastelli"]];
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
