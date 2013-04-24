//
//  ACViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACViewController.h"

@interface ACViewController ()

@end

@implementation ACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.scrollView setContentSize:CGSizeMake(320, 568)];
    
    NSString *keyPath = @"position.x";
    id toValue = [NSNumber numberWithFloat:160];
    
    [self performBlock:^{
        ACBounceAnimation *aboutBounce = [ACBounceAnimation animationWithKeyPath:keyPath];
        aboutBounce.fromValue = [NSNumber numberWithFloat:self.about.center.x];
        aboutBounce.toValue = toValue;
        aboutBounce.duration = 0.6f;
        aboutBounce.numberOfBounces = 4;
        aboutBounce.shouldOvershoot = YES;
        
        [self.about.layer addAnimation:aboutBounce forKey:@"bounce"];
        [self.about.layer setValue:toValue forKeyPath:keyPath];
    } afterDelay:1];
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
