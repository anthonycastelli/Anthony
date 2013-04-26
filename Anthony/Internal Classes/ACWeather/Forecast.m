//
//  Forecast.m
//  Anthony
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "Forecast.h"

@implementation Forecast

@synthesize cond;
@synthesize date;
@synthesize high;
@synthesize low;
@synthesize rain;
@synthesize snow;
@synthesize sunrise;
@synthesize sunset;
@synthesize uv;
@synthesize wdir;
@synthesize wspeed;

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.cond forKey:@"cond"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.high forKey:@"high"];
    [encoder encodeObject:self.low forKey:@"low"];
    [encoder encodeObject:self.rain forKey:@"rain"];
    [encoder encodeObject:self.snow forKey:@"snow"];
    [encoder encodeObject:self.sunrise forKey:@"sunrise"];
    [encoder encodeObject:self.sunset forKey:@"sunset"];
    [encoder encodeObject:self.uv forKey:@"uv"];
    [encoder encodeObject:self.wdir forKey:@"wdir"];
    [encoder encodeObject:self.wspeed forKey:@"wspeed"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.cond = [decoder decodeObjectForKey:@"cond"];
        self.date = [decoder decodeObjectForKey:@"date"];
        self.high = [decoder decodeObjectForKey:@"high"];
        self.low = [decoder decodeObjectForKey:@"low"];
        self.rain = [decoder decodeObjectForKey:@"rain"];
        self.snow = [decoder decodeObjectForKey:@"snow"];
        self.sunrise = [decoder decodeObjectForKey:@"sunrise"];
        self.sunset = [decoder decodeObjectForKey:@"sunset"];
        self.uv = [decoder decodeObjectForKey:@"uv"];
        self.wdir = [decoder decodeObjectForKey:@"wdir"];
        self.wspeed = [decoder decodeObjectForKey:@"wspeed"];
    }
    return self;
}

+ (Forecast *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Forecast *instance = [[Forecast alloc] init];
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
