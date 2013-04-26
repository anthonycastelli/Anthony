//
//  UIWeather.h
//  Thermometer
//
//  Created by Anthony on 5/1/12.
//  Copyright (c) 2012 Tapbits. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    UIWeatherServiceBugged,
    UIWeatherServiceWorld,
    UIWeatherServiceOutside
} UIWeatherService;

@class UIWeather;

@protocol UIWeatherDelegate <NSObject>

- (void)weather:(UIWeather *)weather didReceiveForecast:(NSDictionary *)forecast;

@end

@interface UIWeather : NSObject {
    id <UIWeatherDelegate> delegate;
    NSMutableData *receivedData;
    NSURLConnection *outsideConnection;
    NSURLConnection *worldConnection;
    NSURLConnection *buggedConnection;
}

@property (nonatomic, assign) id <UIWeatherDelegate> delegate;
@property (readwrite, retain) NSMutableData *receivedData;

- (void)getWeatherForLocation:(NSString *)location;
- (void)getWeatherForLatitude:(NSString *)latitude andLongitude:(NSString *)longitude withServerice:(UIWeatherService)service;
- (void)getWeatherForLatitude:(NSString *)latitude andLongitude:(NSString *)longitude;

@end
