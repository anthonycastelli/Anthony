//
//  Weather.m
//  
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "Weather.h"

#import "WeatherCurrently.h"
#import "WeatherDaily.h"
#import "WeatherFlags.h"
#import "WeatherHourly.h"
#import "WeatherMinutely.h"

@implementation Weather

@synthesize currently;
@synthesize daily;
@synthesize flags;
@synthesize hourly;
@synthesize latitude;
@synthesize longitude;
@synthesize minutely;
@synthesize offset;
@synthesize timezone;

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.currently forKey:@"currently"];
    [encoder encodeObject:self.daily forKey:@"daily"];
    [encoder encodeObject:self.flags forKey:@"flags"];
    [encoder encodeObject:self.hourly forKey:@"hourly"];
    [encoder encodeObject:self.latitude forKey:@"latitude"];
    [encoder encodeObject:self.longitude forKey:@"longitude"];
    [encoder encodeObject:self.minutely forKey:@"minutely"];
    [encoder encodeObject:self.offset forKey:@"offset"];
    [encoder encodeObject:self.timezone forKey:@"timezone"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.currently = [decoder decodeObjectForKey:@"currently"];
        self.daily = [decoder decodeObjectForKey:@"daily"];
        self.flags = [decoder decodeObjectForKey:@"flags"];
        self.hourly = [decoder decodeObjectForKey:@"hourly"];
        self.latitude = [decoder decodeObjectForKey:@"latitude"];
        self.longitude = [decoder decodeObjectForKey:@"longitude"];
        self.minutely = [decoder decodeObjectForKey:@"minutely"];
        self.offset = [decoder decodeObjectForKey:@"offset"];
        self.timezone = [decoder decodeObjectForKey:@"timezone"];
    }
    return self;
}

+ (Weather *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Weather *instance = [[Weather alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forKey:(NSString *)key {

    if ([key isEqualToString:@"currently"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.currently = [WeatherCurrently instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"daily"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.daily = [WeatherDaily instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"flags"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.flags = [WeatherFlags instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"hourly"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.hourly = [WeatherHourly instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"minutely"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.minutely = [WeatherMinutely instanceFromDictionary:value];
        }

    } else {
        @try {
            [super setValue:value forUndefinedKey:key];
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
        }
    }

}


@end
