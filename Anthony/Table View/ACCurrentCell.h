//
//  ACCurrentCell.h
//  Anthony
//
//  Created by Anthony Castelli on 4/25/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ACForecastColorBlue,
    ACForecastColorGreen,
    ACForecastColorYellow,
    ACForecastColorOrange
} ACForecastColor;

@interface ACCurrentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *currentTemp;
@property (weak, nonatomic) IBOutlet UILabel *highLow;
@property (weak, nonatomic) IBOutlet UILabel *condition;
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UIImageView *condtionImage;
@property (weak, nonatomic) IBOutlet UIImageView *background;

- (void)setForecastColor:(ACForecastColor)color;
- (void)spinView:(UIView *)view;
- (void)bounceView:(UIView *)view InToPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;

@end
