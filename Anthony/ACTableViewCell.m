//
//  ACTableViewCell.m
//  Anthony
//
//  Created by Anthony Castelli on 4/24/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACTableViewCell.h"

@implementation ACTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)bounceImageInToPoint:(CGPoint)point {
    NSString *keyPath = @"position.x";
    id toValue = [NSNumber numberWithFloat:point.x];
    ACBounceAnimation *bounce = [ACBounceAnimation animationWithKeyPath:keyPath];
    bounce.fromValue = [NSNumber numberWithFloat:self.imageView.center.x];
    bounce.toValue = toValue;
    bounce.duration = 0.6f;
    bounce.numberOfBounces = 4;
    bounce.shouldOvershoot = YES;
    
    [self.imageView.layer addAnimation:bounce forKey:@"bounce"];
    [self.imageView.layer setValue:toValue forKeyPath:keyPath];
}

@end
