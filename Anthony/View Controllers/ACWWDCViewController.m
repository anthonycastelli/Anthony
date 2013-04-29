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
    
    // Setup in background
    [self.background setImage:[[UIImage imageNamed:@"about_background"] stretchableImageWithLeftCapWidth:160 topCapHeight:54]];
    [self.background setContentMode:UIViewContentModeScaleToFill];
    
    // Setup the swipe gesture
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipe];
    
    // WWDC text
	NSString *wwdc = @"Attending WWDC has been one of my biggest dreams. Always making sure my school work was completed for the day of the keynote, allowed me the time to follow along with  the keynote presentations.  WWDC is much more than just watching or reading a keynote to me, its about learning from the worlds greatest software engineers, who are all present; teaching seminars, explaining new technology, and helping developers of all ages further their knowledge. WWDC is a place where I would have the opportunity to introduce myself to many world class developers and further my knowledge in a field that I am devoted to. ";
    
    NSDictionary *defaultAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.437 green:0.494 blue:0.609 alpha:1.000],
                                        NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0]};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:wwdc attributes:defaultAttributes];
    
    [self.textView setAttributedText:attributedString];
    
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
