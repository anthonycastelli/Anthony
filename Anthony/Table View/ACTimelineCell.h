//
//  ACTimelineCell.h
//  Anthony
//
//  Created by Anthony Castelli on 4/25/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACTimelineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIImageView *dimonds;
@property (weak, nonatomic) IBOutlet UIImageView *types;
@property (weak, nonatomic) IBOutlet UIImageView *lines;
@property (weak, nonatomic) IBOutlet UIImageView *info;

- (void)bounceImage:(UIImageView *)imageView InToPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;

@end
