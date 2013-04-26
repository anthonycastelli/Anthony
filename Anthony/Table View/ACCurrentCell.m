//
//  ACCurrentCell.m
//  Anthony
//
//  Created by Anthony Castelli on 4/25/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACCurrentCell.h"

@implementation ACCurrentCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setForecastColor:(ACForecastColor)color {
    switch (color) {
        case ACForecastColorBlue:
            [self.highLow setTextColor:[UIColor colorWithRed:0.075 green:0.486 blue:0.773 alpha:1.000]];
            [self.day setTextColor:[UIColor colorWithRed:0.075 green:0.486 blue:0.773 alpha:1.000]];
            [self.location setTextColor:[UIColor colorWithRed:0.075 green:0.486 blue:0.773 alpha:1.000]];
            [self.background setImage:[UIImage imageNamed:@"weather_current_blue"]];
            break;
        case ACForecastColorGreen:
            [self.highLow setTextColor:[UIColor colorWithRed:0.196 green:0.643 blue:0.106 alpha:1.000]];
            [self.day setTextColor:[UIColor colorWithRed:0.196 green:0.643 blue:0.106 alpha:1.000]];
            [self.location setTextColor:[UIColor colorWithRed:0.196 green:0.643 blue:0.106 alpha:1.000]];
            [self.background setImage:[UIImage imageNamed:@"weather_current_green"]];
            break;
        case ACForecastColorYellow:
            [self.highLow setTextColor:[UIColor colorWithRed:0.886 green:0.749 blue:0.165 alpha:1.000]];
            [self.day setTextColor:[UIColor colorWithRed:0.886 green:0.749 blue:0.165 alpha:1.000]];
            [self.location setTextColor:[UIColor colorWithRed:0.886 green:0.749 blue:0.165 alpha:1.000]];
            [self.background setImage:[UIImage imageNamed:@"weather_current_yellow"]];
            break;
        case ACForecastColorOrange:
            [self.highLow setTextColor:[UIColor colorWithRed:0.882 green:0.325 blue:0.106 alpha:1.000]];
            [self.day setTextColor:[UIColor colorWithRed:0.882 green:0.325 blue:0.106 alpha:1.000]];
            [self.location setTextColor:[UIColor colorWithRed:0.882 green:0.325 blue:0.106 alpha:1.000]];
            [self.background setImage:[UIImage imageNamed:@"weather_current_orange"]];
            break;
        default:
            break;
    }
}

- (void)spinView:(UIView *)view {
    
}

- (void)bounceView:(UIView *)view InToPoint:(CGPoint)point withDelay:(NSTimeInterval)delay {
    [self performBlock:^{
        NSString *keyPath = @"position.x";
        id toValue = [NSNumber numberWithFloat:point.x];
        ACBounceAnimation *bounce = [ACBounceAnimation animationWithKeyPath:keyPath];
        bounce.fromValue = [NSNumber numberWithFloat:view.center.x];
        bounce.toValue = toValue;
        bounce.duration = 0.6f;
        bounce.numberOfBounces = 4;
        bounce.shouldOvershoot = YES;
        
        [view.layer addAnimation:bounce forKey:@"bounce"];
        [view.layer setValue:toValue forKeyPath:keyPath];
    } afterDelay:delay];
}

@end
