//
//  ACTableViewCell.h
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageLabel;

- (void)bounceImageInToPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;

@end
