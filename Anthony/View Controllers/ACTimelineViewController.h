//
//  ACTimelineViewController.h
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACTimelineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *timeline;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

- (IBAction)back:(id)sender;

@end
