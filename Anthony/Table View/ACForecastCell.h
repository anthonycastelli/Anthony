//
//  ACForecastCell.h
//  Anthony
//
//  Created by Anthony Castelli on 4/25/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACForecastCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *condition;
@property (weak, nonatomic) IBOutlet UILabel *temp;
@property (weak, nonatomic) IBOutlet UILabel *day;

- (void)bounceView:(UIView *)view InToPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;

@end
