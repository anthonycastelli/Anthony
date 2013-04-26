//
//  WeatherFlags.m
//  
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "WeatherFlags.h"

@implementation WeatherFlags

@synthesize darkskyStations;
@synthesize isdStations;
@synthesize lampStations;
@synthesize metarStations;
@synthesize sources;
@synthesize units;

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.darkskyStations forKey:@"darkskyStations"];
    [encoder encodeObject:self.isdStations forKey:@"isdStations"];
    [encoder encodeObject:self.lampStations forKey:@"lampStations"];
    [encoder encodeObject:self.metarStations forKey:@"metarStations"];
    [encoder encodeObject:self.sources forKey:@"sources"];
    [encoder encodeObject:self.units forKey:@"units"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.darkskyStations = [decoder decodeObjectForKey:@"darkskyStations"];
        self.isdStations = [decoder decodeObjectForKey:@"isdStations"];
        self.lampStations = [decoder decodeObjectForKey:@"lampStations"];
        self.metarStations = [decoder decodeObjectForKey:@"metarStations"];
        self.sources = [decoder decodeObjectForKey:@"sources"];
        self.units = [decoder decodeObjectForKey:@"units"];
    }
    return self;
}

+ (WeatherFlags *)instanceFromDictionary:(NSDictionary *)aDictionary {

    WeatherFlags *instance = [[WeatherFlags alloc] init];
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

    if ([key isEqualToString:@"darksky-stations"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                [myMembers addObject:valueMember];
            }

            self.darkskyStations = myMembers;

        }

    } else if ([key isEqualToString:@"isd-stations"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                [myMembers addObject:valueMember];
            }

            self.isdStations = myMembers;

        }

    } else if ([key isEqualToString:@"lamp-stations"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                [myMembers addObject:valueMember];
            }

            self.lampStations = myMembers;

        }

    } else if ([key isEqualToString:@"metar-stations"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                [myMembers addObject:valueMember];
            }

            self.metarStations = myMembers;

        }

    } else if ([key isEqualToString:@"sources"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                [myMembers addObject:valueMember];
            }

            self.sources = myMembers;

        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"darksky-stations"]) {
        [self setValue:value forKey:@"darkskyStations"];
    } else if ([key isEqualToString:@"isd-stations"]) {
        [self setValue:value forKey:@"isdStations"];
    } else if ([key isEqualToString:@"lamp-stations"]) {
        [self setValue:value forKey:@"lampStations"];
    } else if ([key isEqualToString:@"metar-stations"]) {
        [self setValue:value forKey:@"metarStations"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}


@end
