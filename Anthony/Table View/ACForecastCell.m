//
//  ACForecastCell.m
//  Anthony
//
//  Created by Anthony Castelli on 4/25/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACForecastCell.h"

@implementation ACForecastCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setForecastColor:(ACForecastDayColor)color {
    switch (color) {
        case ACForecastDayColorBlue:
            [self.background setImage:[UIImage imageNamed:@"weather_current_blue"]];
            break;
        case ACForecastDayColorGreen:
            [self.background setImage:[UIImage imageNamed:@"weather_current_green"]];
            break;
        case ACForecastDayColorYellow:
            [self.background setImage:[UIImage imageNamed:@"weather_current_yellow"]];
            break;
        case ACForecastDayColorOrange:
            [self.background setImage:[UIImage imageNamed:@"weather_current_orange"]];
            break;
        default:
            break;
    }
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
