//
//  WeatherCurrently.m
//  
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "WeatherCurrently.h"

@implementation WeatherCurrently

@synthesize cloudCover;
@synthesize dewPoint;
@synthesize humidity;
@synthesize icon;
@synthesize ozone;
@synthesize precipIntensity;
@synthesize pressure;
@synthesize summary;
@synthesize temperature;
@synthesize time;
@synthesize visibility;
@synthesize windBearing;
@synthesize windSpeed;

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.cloudCover forKey:@"cloudCover"];
    [encoder encodeObject:self.dewPoint forKey:@"dewPoint"];
    [encoder encodeObject:self.humidity forKey:@"humidity"];
    [encoder encodeObject:self.icon forKey:@"icon"];
    [encoder encodeObject:self.ozone forKey:@"ozone"];
    [encoder encodeObject:self.precipIntensity forKey:@"precipIntensity"];
    [encoder encodeObject:self.pressure forKey:@"pressure"];
    [encoder encodeObject:self.summary forKey:@"summary"];
    [encoder encodeObject:self.temperature forKey:@"temperature"];
    [encoder encodeObject:self.time forKey:@"time"];
    [encoder encodeObject:self.visibility forKey:@"visibility"];
    [encoder encodeObject:self.windBearing forKey:@"windBearing"];
    [encoder encodeObject:self.windSpeed forKey:@"windSpeed"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.cloudCover = [decoder decodeObjectForKey:@"cloudCover"];
        self.dewPoint = [decoder decodeObjectForKey:@"dewPoint"];
        self.humidity = [decoder decodeObjectForKey:@"humidity"];
        self.icon = [decoder decodeObjectForKey:@"icon"];
        self.ozone = [decoder decodeObjectForKey:@"ozone"];
        self.precipIntensity = [decoder decodeObjectForKey:@"precipIntensity"];
        self.pressure = [decoder decodeObjectForKey:@"pressure"];
        self.summary = [decoder decodeObjectForKey:@"summary"];
        self.temperature = [decoder decodeObjectForKey:@"temperature"];
        self.time = [decoder decodeObjectForKey:@"time"];
        self.visibility = [decoder decodeObjectForKey:@"visibility"];
        self.windBearing = [decoder decodeObjectForKey:@"windBearing"];
        self.windSpeed = [decoder decodeObjectForKey:@"windSpeed"];
    }
    return self;
}

+ (WeatherCurrently *)instanceFromDictionary:(NSDictionary *)aDictionary {

    WeatherCurrently *instance = [[WeatherCurrently alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

@end
