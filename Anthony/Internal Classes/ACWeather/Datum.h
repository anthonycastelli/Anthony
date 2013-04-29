//
//  Datum.h
//  
//
//  Created by Anthony Castelli on 4/27/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Datum : NSObject <NSCoding> {
    NSNumber *cloudCover;
    NSNumber *dewPoint;
    NSNumber *humidity;
    NSString *icon;
    NSNumber *ozone;
    NSNumber *precipIntensity;
    NSNumber *precipIntensityMax;
    NSNumber *pressure;
    NSString *summary;
    NSNumber *sunriseTime;
    NSNumber *sunsetTime;
    NSNumber *temperature;
    NSNumber *temperatureMax;
    NSNumber *temperatureMaxTime;
    NSNumber *temperatureMin;
    NSNumber *temperatureMinTime;
    NSNumber *time;
    NSNumber *visibility;
    NSNumber *windBearing;
    NSNumber *windSpeed;
    NSString *precipType;
}

@property (nonatomic, copy) NSNumber *cloudCover;
@property (nonatomic, copy) NSNumber *dewPoint;
@property (nonatomic, copy) NSNumber *humidity;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSNumber *ozone;
@property (nonatomic, copy) NSNumber *precipIntensity;
@property (nonatomic, copy) NSNumber *precipIntensityMax;
@property (nonatomic, copy) NSNumber *pressure;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSNumber *sunriseTime;
@property (nonatomic, copy) NSNumber *sunsetTime;
@property (nonatomic, copy) NSNumber *temperature;
@property (nonatomic, copy) NSNumber *temperatureMax;
@property (nonatomic, copy) NSNumber *temperatureMaxTime;
@property (nonatomic, copy) NSNumber *temperatureMin;
@property (nonatomic, copy) NSNumber *temperatureMinTime;
@property (nonatomic, copy) NSNumber *time;
@property (nonatomic, copy) NSNumber *visibility;
@property (nonatomic, copy) NSNumber *windBearing;
@property (nonatomic, copy) NSNumber *windSpeed;
@property (nonatomic, copy) NSString *precipType;

+ (Datum *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
