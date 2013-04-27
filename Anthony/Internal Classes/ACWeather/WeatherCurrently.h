//
//  WeatherCurrently.h
//  
//
//  Created by Anthony Castelli on 4/27/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherCurrently : NSObject <NSCoding> {
    NSNumber *cloudCover;
    NSNumber *dewPoint;
    NSNumber *humidity;
    NSString *icon;
    NSNumber *ozone;
    NSNumber *precipIntensity;
    NSNumber *pressure;
    NSString *summary;
    NSNumber *temperature;
    NSNumber *time;
    NSNumber *visibility;
    NSNumber *windBearing;
    NSNumber *windSpeed;
}

@property (nonatomic, copy) NSNumber *cloudCover;
@property (nonatomic, copy) NSNumber *dewPoint;
@property (nonatomic, copy) NSNumber *humidity;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSNumber *ozone;
@property (nonatomic, copy) NSNumber *precipIntensity;
@property (nonatomic, copy) NSNumber *pressure;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSNumber *temperature;
@property (nonatomic, copy) NSNumber *time;
@property (nonatomic, copy) NSNumber *visibility;
@property (nonatomic, copy) NSNumber *windBearing;
@property (nonatomic, copy) NSNumber *windSpeed;

+ (WeatherCurrently *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
