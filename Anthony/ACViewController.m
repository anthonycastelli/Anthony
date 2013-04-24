//
//  ACViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACViewController.h"
#define aboutTime 0.2
#define timelineTime 0.25
#define appsTime 0.3
#define designTime 0.35
#define wwdcTime 0.4

@interface ACViewController ()

@end

@implementation ACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.scrollView setContentSize:CGSizeMake(320, 568)];
    
    NSString *keyPath = @"position.x";
    id toValue = [NSNumber numberWithFloat:160];
    
    // About Bounce
    [self performBlock:^{
        ACBounceAnimation *bounce = [ACBounceAnimation animationWithKeyPath:keyPath];
        bounce.fromValue = [NSNumber numberWithFloat:self.about.center.x];
        bounce.toValue = toValue;
        bounce.duration = 0.6f;
        bounce.numberOfBounces = 4;
        bounce.shouldOvershoot = YES;
        
        [self.about.layer addAnimation:bounce forKey:@"bounce"];
        [self.about.layer setValue:toValue forKeyPath:keyPath];
    } afterDelay:aboutTime];
    
    // Timeline Bounce
    [self performBlock:^{
        ACBounceAnimation *bounce = [ACBounceAnimation animationWithKeyPath:keyPath];
        bounce.fromValue = [NSNumber numberWithFloat:self.timeline.center.x];
        bounce.toValue = toValue;
        bounce.duration = 0.6f;
        bounce.numberOfBounces = 4;
        bounce.shouldOvershoot = YES;
        
        [self.timeline.layer addAnimation:bounce forKey:@"bounce"];
        [self.timeline.layer setValue:toValue forKeyPath:keyPath];
    } afterDelay:timelineTime];
    
    // Apps Bounce
    [self performBlock:^{
        ACBounceAnimation *bounce = [ACBounceAnimation animationWithKeyPath:keyPath];
        bounce.fromValue = [NSNumber numberWithFloat:self.apps.center.x];
        bounce.toValue = toValue;
        bounce.duration = 0.6f;
        bounce.numberOfBounces = 4;
        bounce.shouldOvershoot = YES;
        
        [self.apps.layer addAnimation:bounce forKey:@"bounce"];
        [self.apps.layer setValue:toValue forKeyPath:keyPath];
    } afterDelay:appsTime];
    
    // Designs Bounce
    [self performBlock:^{
        ACBounceAnimation *bounce = [ACBounceAnimation animationWithKeyPath:keyPath];
        bounce.fromValue = [NSNumber numberWithFloat:self.designs.center.x];
        bounce.toValue = toValue;
        bounce.duration = 0.6f;
        bounce.numberOfBounces = 4;
        bounce.shouldOvershoot = YES;
        
        [self.designs.layer addAnimation:bounce forKey:@"bounce"];
        [self.designs.layer setValue:toValue forKeyPath:keyPath];
    } afterDelay:designTime];
    
    // WWDC Bounce
    [self performBlock:^{
        ACBounceAnimation *bounce = [ACBounceAnimation animationWithKeyPath:keyPath];
        bounce.fromValue = [NSNumber numberWithFloat:self.wwdc.center.x];
        bounce.toValue = toValue;
        bounce.duration = 0.6f;
        bounce.numberOfBounces = 4;
        bounce.shouldOvershoot = YES;
        
        [self.wwdc.layer addAnimation:bounce forKey:@"bounce"];
        [self.wwdc.layer setValue:toValue forKeyPath:keyPath];
    } afterDelay:wwdcTime];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Options

- (IBAction)about:(id)sender {
    
}

- (IBAction)timeline:(id)sender {
    
}

- (IBAction)apps:(id)sender {
    
}

- (IBAction)design:(id)sender {
    
}

- (IBAction)wwdc:(id)sender {
    
}

@end
