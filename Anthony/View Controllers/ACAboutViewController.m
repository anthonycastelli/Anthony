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
@property (nonatomic, retain) ACAlertView *emailAlert;

- (void)animateIn;
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
    [self animateIn];
    
    // Setup the swipe gesture
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipe];
    
    // About me text
	NSString *about = @"I was born in southern California and lived there for five years before moving to Reno, Nevada. At the age of four, I first began to play tennis, and continued playing tennis at the Reno Tennis Centre, Nevada. Participating in various tennis tournaments over the years, and joining the Galena Tennis team in 2009 for four years, during high school. I was ranked as the teams number one tennis player in my senior year, as well as attaining the position of team captain. \n\nI have always been homeschooled which allowed me to concentrate on my passion as well as completing my school work. At the age of 11, I became very interested in computers and began learning how they were built, how they functioned, and how the system performed each task. Within six months, I began to teach myself how to develop software for the OS X platform and quickly became the family, friends, and the neighborhood tech genius. \n\nOver the years I continued to learn and create new and exciting productivity applications for the mac. When the iPhone was released in 2007, I knew it was a prime opportunity to begin selling my apps. While working as a tennis coach at the Reno tennis Centre, and taking on various jobs, my curiosity in photography led me to save up for my first DSLR camera. I spent much of my free time playing playing tennis, working on my iPhone apps, learning about photography and doing volunteer work. \n\nLearning CSS and HTML lead me to web design and development, and in February 2011, I assisted with the re-design of, “Rain A Tribute to the Beatle’s” web site. (http://raintribute.com) Everything from the content management system to the design and layout was my area of involvement. \n\nSince October, 2012, I began volunteering for the Children’s Cabinet, where I helped manage hundreds of servers and computers that were streamed across the state of Nevada. At the end of 2012, I founded my own company, Emerys, where I currently design and develop iOS and OS X apps.";

    NSDictionary *defaultAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.437 green:0.494 blue:0.609 alpha:1.000],
                                        NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0]};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:about attributes:defaultAttributes];
    
    [self.textView setAttributedText:attributedString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)animateIn {
    [self animateView:self.anthony toPoint:CGPointMake(160, 30) withDelay:0.3];
    [self animateView:self.backButton toPoint:CGPointMake(30, 30) withDelay:0.35];
    [self animateView:self.textView toPoint:CGPointMake(160, 274) withDelay:0.4];
    [self animateView:self.emerys toPoint:CGPointMake(32, 516) withDelay:0.5];
    [self animateView:self.twitter toPoint:CGPointMake(96, 516) withDelay:0.55];
    [self animateView:self.adn toPoint:CGPointMake(160, 516) withDelay:0.6];
    [self animateView:self.dribbble toPoint:CGPointMake(224, 516) withDelay:0.65];
    [self animateView:self.email toPoint:CGPointMake(288, 516) withDelay:0.7];
}

#pragma mark - Options

- (IBAction)back:(id)sender {
    [self animateView:self.backButton toPoint:CGPointMake(350, 30) withDelay:0.12];
    [self animateView:self.anthony toPoint:CGPointMake(480, 30) withDelay:0.10];
    [self animateView:self.textView toPoint:CGPointMake(460, 274) withDelay:0.09];
    [self animateView:self.emerys toPoint:CGPointMake(352, 516) withDelay:0.07];
    [self animateView:self.twitter toPoint:CGPointMake(416, 516) withDelay:0.05];
    [self animateView:self.adn toPoint:CGPointMake(480, 516) withDelay:0.03];
    [self animateView:self.dribbble toPoint:CGPointMake(544, 516) withDelay:0.02];
    [self animateView:self.email toPoint:CGPointMake(608, 516) withDelay:0.0];
    
    [self performBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    } afterDelay:0.1];
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

- (IBAction)email:(id)sender {
    [self shakeView:self.email withDistance:6.0f];
    [self openAction:ACAboutActionEmail];
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
        case ACAboutActionEmail:
            self.emailAlert = [[ACAlertView alloc] initWithTitle:@"Email"
                                                          message:@"Want to get in touch with me? Click okay and you can begin typing your message."
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Okay", nil];
            [self.emailAlert show];
            break;
        default:
            break;
    }
}

#pragma mark - ACAlertView Delegate

- (void)alertView:(ACAlertView *)alertView tappedButtonAtIndex:(NSInteger)index {
    [ACAlertView setGlobalAcceptButtonDismissalAnimationStyle:ACAlertViewDismissalStyleFall];
    [ACAlertView setGlobalCancelButtonDismissalAnimationStyle:ACAlertViewDismissalStyleFall];
    
    if (alertView == self.emerysAlert) if (index == 1) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://emerys.co/"]];
    
    if (alertView == self.twitterAlert) if (index == 1) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/neueanthony"]];
    
    if (alertView == self.appnetAlert) if (index == 1) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://alpha.app.net/amc"]];
    
    if (alertView == self.dribbbleAlert) if (index == 1) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://dribbble.com/amc"]];
    
    if (alertView == self.emailAlert) {
        if (index == 1) {
            MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
            [mail setMailComposeDelegate:self];
            
            [mail setSubject:@""];
            [mail setMessageBody:@"" isHTML:NO];
            [mail setToRecipients:@[@"anthony@emerys.co"]];
            
            [self presentViewController:mail animated:YES completion:nil];
        }
    }
}

#pragma mark - Mail Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self animateIn];
    [self dismissViewControllerAnimated:YES completion:nil];
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
