//
//  ACAboutViewController.h
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ACAboutActionEmerys,
    ACAboutActionTwitter,
    ACAboutActionAppDotNet,
    ACAboutActionDribbble,
    ACAboutActionEmail
} ACAboutAction;

@interface ACAboutViewController : UIViewController <ACAlertViewDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *navigationbar;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *emerys;
@property (weak, nonatomic) IBOutlet UIButton *twitter;
@property (weak, nonatomic) IBOutlet UIButton *adn;
@property (weak, nonatomic) IBOutlet UIButton *dribbble;
@property (weak, nonatomic) IBOutlet UIButton *email;

- (IBAction)back:(id)sender;
- (IBAction)emerys:(id)sender;
- (IBAction)twitter:(id)sender;
- (IBAction)adn:(id)sender;
- (IBAction)dribbble:(id)sender;
- (IBAction)email:(id)sender;

- (void)openAction:(ACAboutAction)action;

@end
