//
//  ACDesignsCell.h
//  Anthony
//
//  Created by Anthony Castelli on 4/27/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACDesignsCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *design;
@property (weak, nonatomic) UIImageView *border;

- (void)bounceView:(UIView *)view InToPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;

@end
