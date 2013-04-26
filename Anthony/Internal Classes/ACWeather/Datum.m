//
//  Datum.m
//  
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "Datum.h"

@implementation Datum

@synthesize cloudCover;
@synthesize dewPoint;
@synthesize humidity;
@synthesize icon;
@synthesize ozone;
@synthesize precipIntensity;
@synthesize precipIntensityMax;
@synthesize pressure;
@synthesize summary;
@synthesize sunriseTime;
@synthesize sunsetTime;
@synthesize temperature;
@synthesize temperatureMax;
@synthesize temperatureMaxTime;
@synthesize temperatureMin;
@synthesize temperatureMinTime;
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
    [encoder encodeObject:self.precipIntensityMax forKey:@"precipIntensityMax"];
    [encoder encodeObject:self.pressure forKey:@"pressure"];
    [encoder encodeObject:self.summary forKey:@"summary"];
    [encoder encodeObject:self.sunriseTime forKey:@"sunriseTime"];
    [encoder encodeObject:self.sunsetTime forKey:@"sunsetTime"];
    [encoder encodeObject:self.temperature forKey:@"temperature"];
    [encoder encodeObject:self.temperatureMax forKey:@"temperatureMax"];
    [encoder encodeObject:self.temperatureMaxTime forKey:@"temperatureMaxTime"];
    [encoder encodeObject:self.temperatureMin forKey:@"temperatureMin"];
    [encoder encodeObject:self.temperatureMinTime forKey:@"temperatureMinTime"];
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
        self.precipIntensityMax = [decoder decodeObjectForKey:@"precipIntensityMax"];
        self.pressure = [decoder decodeObjectForKey:@"pressure"];
        self.summary = [decoder decodeObjectForKey:@"summary"];
        self.sunriseTime = [decoder decodeObjectForKey:@"sunriseTime"];
        self.sunsetTime = [decoder decodeObjectForKey:@"sunsetTime"];
        self.temperature = [decoder decodeObjectForKey:@"temperature"];
        self.temperatureMax = [decoder decodeObjectForKey:@"temperatureMax"];
        self.temperatureMaxTime = [decoder decodeObjectForKey:@"temperatureMaxTime"];
        self.temperatureMin = [decoder decodeObjectForKey:@"temperatureMin"];
        self.temperatureMinTime = [decoder decodeObjectForKey:@"temperatureMinTime"];
        self.time = [decoder decodeObjectForKey:@"time"];
        self.visibility = [decoder decodeObjectForKey:@"visibility"];
        self.windBearing = [decoder decodeObjectForKey:@"windBearing"];
        self.windSpeed = [decoder decodeObjectForKey:@"windSpeed"];
    }
    return self;
}

+ (Datum *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Datum *instance = [[Datum alloc] init];
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
