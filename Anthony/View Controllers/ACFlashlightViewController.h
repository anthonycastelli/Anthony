//
//  ACFlashlightViewController.h
//  Anthony
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACFlashlightViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *flashlight;
@property (weak, nonatomic) IBOutlet UIImageView *torchRingOne;
@property (weak, nonatomic) IBOutlet UIImageView *torchRingTwo;
@property (weak, nonatomic) IBOutlet UIImageView *torchRingThree;
@property (weak, nonatomic) IBOutlet UIButton *torchButton;

- (IBAction)back:(id)sender;
- (IBAction)torch:(id)sender;

@end
