//
//  ACViewController.h
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *about;
@property (weak, nonatomic) IBOutlet UIButton *timeline;
@property (weak, nonatomic) IBOutlet UIButton *apps;
@property (weak, nonatomic) IBOutlet UIButton *designs;
@property (weak, nonatomic) IBOutlet UIButton *wwdc;

- (IBAction)about:(id)sender;
- (IBAction)timeline:(id)sender;
- (IBAction)apps:(id)sender;
- (IBAction)design:(id)sender;
- (IBAction)wwdc:(id)sender;

@end
