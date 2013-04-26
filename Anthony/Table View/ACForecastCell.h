//
//  ACForecastCell.h
//  Anthony
//
//  Created by Anthony Castelli on 4/25/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ACForecastDayColorBlue,
    ACForecastDayColorGreen,
    ACForecastDayColorYellow,
    ACForecastDayColorOrange
} ACForecastDayColor;

@interface ACForecastCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *condition;
@property (weak, nonatomic) IBOutlet UILabel *temp;
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UILabel *loading;

- (void)setForecastColor:(ACForecastDayColor)color;
- (void)bounceView:(UIView *)view InToPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;

@end
