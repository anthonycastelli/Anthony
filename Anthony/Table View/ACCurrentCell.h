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

@property (retain, nonatomic) IBOutlet UILabel *currentTemp;
@property (retain, nonatomic) IBOutlet UILabel *highLow;
@property (retain, nonatomic) IBOutlet UILabel *condition;
@property (retain, nonatomic) IBOutlet UILabel *day;
@property (retain, nonatomic) IBOutlet UILabel *location;
@property (retain, nonatomic) IBOutlet UIImageView *condtionImage;
@property (retain, nonatomic) IBOutlet UIImageView *background;

- (void)setForecastColor:(ACForecastColor)color;
- (void)spinView:(UIView *)view withDuration:(CGFloat)duration andRotations:(CGFloat)rotations repeat:(float)repeat;
- (void)bounceView:(UIView *)view InToPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;

@end
