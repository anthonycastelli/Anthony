//
//  ACWeather.h
//  Drizzle
//
//  Created by Anthony on 5/1/12.
//  Copyright (c) 2012 Tapbits. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
#import "Forecast.h"

@class ACWeather;

@protocol ACWeatherDelegate <NSObject>

- (void)weather:(ACWeather *)weather didReceiveForecast:(NSDictionary *)forecast;

@end

@interface ACWeather : NSObject 

@property (nonatomic, assign) id <ACWeatherDelegate> delegate;
@property (readwrite, retain) NSMutableData *receivedData;

+ (ACWeather *)currentWeather;

- (void)getWeatherForLatitude:(NSString *)latitude andLongitude:(NSString *)longitude;

@end
