//
//  ACAppsViewController.h
//  Anthony
//
//  Created by Anthony Castelli on 4/25/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACAppsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *apps;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)back:(id)sender;

@end
