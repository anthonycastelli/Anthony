//
//  ACTimelineViewController.h
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACTimelineViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIImageView *dimonds;
@property (weak, nonatomic) IBOutlet UIImageView *types;
@property (weak, nonatomic) IBOutlet UIImageView *lines;
@property (weak, nonatomic) IBOutlet UIImageView *info;

- (IBAction)back:(id)sender;

@end
