//
//  ACDesignsViewController.h
//  Anthony
//
//  Created by Anthony Castelli on 4/27/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACDesignsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *design;
@property (nonatomic, retain) NSMutableArray *designs;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)back:(id)sender;

@end
