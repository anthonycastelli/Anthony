//
//  Weather.m
//  Anthony
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "Weather.h"

@implementation Weather

@synthesize cloud;
@synthesize cond;
@synthesize dew;
@synthesize feel;
@synthesize forecast;
@synthesize humid;
@synthesize obtime;
@synthesize temp;
@synthesize time;
@synthesize timez;
@synthesize uv;
@synthesize wdir;
@synthesize wspeed;

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.cloud forKey:@"cloud"];
    [encoder encodeObject:self.cond forKey:@"cond"];
    [encoder encodeObject:self.dew forKey:@"dew"];
    [encoder encodeObject:self.feel forKey:@"feel"];
    [encoder encodeObject:self.forecast forKey:@"forecast"];
    [encoder encodeObject:self.humid forKey:@"humid"];
    [encoder encodeObject:self.obtime forKey:@"obtime"];
    [encoder encodeObject:self.temp forKey:@"temp"];
    [encoder encodeObject:self.time forKey:@"time"];
    [encoder encodeObject:self.timez forKey:@"timez"];
    [encoder encodeObject:self.uv forKey:@"uv"];
    [encoder encodeObject:self.wdir forKey:@"wdir"];
    [encoder encodeObject:self.wspeed forKey:@"wspeed"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.cloud = [decoder decodeObjectForKey:@"cloud"];
        self.cond = [decoder decodeObjectForKey:@"cond"];
        self.dew = [decoder decodeObjectForKey:@"dew"];
        self.feel = [decoder decodeObjectForKey:@"feel"];
        self.forecast = [decoder decodeObjectForKey:@"forecast"];
        self.humid = [decoder decodeObjectForKey:@"humid"];
        self.obtime = [decoder decodeObjectForKey:@"obtime"];
        self.temp = [decoder decodeObjectForKey:@"temp"];
        self.time = [decoder decodeObjectForKey:@"time"];
        self.timez = [decoder decodeObjectForKey:@"timez"];
        self.uv = [decoder decodeObjectForKey:@"uv"];
        self.wdir = [decoder decodeObjectForKey:@"wdir"];
        self.wspeed = [decoder decodeObjectForKey:@"wspeed"];
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

    if ([key isEqualToString:@"forecast"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                Forecast *populatedMember = [Forecast instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }

            self.forecast = myMembers;

        }

    } else {
        [super setValue:value forKey:key];
    }

}


@end
