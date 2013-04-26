//
//  ACTimelineCell.m
//  Anthony
//
//  Created by Anthony Castelli on 4/25/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACTimelineCell.h"

@implementation ACTimelineCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bounceImage:(UIImageView *)imageView InToPoint:(CGPoint)point withDelay:(NSTimeInterval)delay {
    [self performBlock:^{
        NSString *keyPath = @"position.x";
        id toValue = [NSNumber numberWithFloat:point.x];
        ACBounceAnimation *bounce = [ACBounceAnimation animationWithKeyPath:keyPath];
        bounce.fromValue = [NSNumber numberWithFloat:imageView.center.x];
        bounce.toValue = toValue;
        bounce.duration = 0.6f;
        bounce.numberOfBounces = 4;
        bounce.shouldOvershoot = YES;
        
        [imageView.layer addAnimation:bounce forKey:@"bounce"];
        [imageView.layer setValue:toValue forKeyPath:keyPath];
    } afterDelay:delay];
}

@end
