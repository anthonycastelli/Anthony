//
//  ACWWDCViewController.h
//  Anthony
//
//  Created by Anthony Castelli on 4/28/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACWWDCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *wwdc;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *background;

- (IBAction)back:(id)sender;

@end
