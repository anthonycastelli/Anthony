//
//  Weather.h
//  
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherCurrently.h"
#import "WeatherDaily.h"
#import "WeatherFlags.h"
#import "WeatherHourly.h"
#import "WeatherMinutely.h"

@class WeatherCurrently;
@class WeatherDaily;
@class WeatherFlags;
@class WeatherHourly;
@class WeatherMinutely;

@interface Weather : NSObject <NSCoding> {
    WeatherCurrently *currently;
    WeatherDaily *daily;
    WeatherFlags *flags;
    WeatherHourly *hourly;
    NSNumber *latitude;
    NSNumber *longitude;
    WeatherMinutely *minutely;
    NSNumber *offset;
    NSString *timezone;
}

@property (nonatomic, strong) WeatherCurrently *currently;
@property (nonatomic, strong) WeatherDaily *daily;
@property (nonatomic, strong) WeatherFlags *flags;
@property (nonatomic, strong) WeatherHourly *hourly;
@property (nonatomic, copy) NSNumber *latitude;
@property (nonatomic, copy) NSNumber *longitude;
@property (nonatomic, strong) WeatherMinutely *minutely;
@property (nonatomic, copy) NSNumber *offset;
@property (nonatomic, copy) NSString *timezone;

+ (Weather *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
