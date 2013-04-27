//
//  WeatherHourly.m
//  
//
//  Created by Anthony Castelli on 4/27/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "WeatherHourly.h"

#import "Datum.h"

@implementation WeatherHourly

@synthesize data;
@synthesize icon;
@synthesize summary;

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.data forKey:@"data"];
    [encoder encodeObject:self.icon forKey:@"icon"];
    [encoder encodeObject:self.summary forKey:@"summary"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.data = [decoder decodeObjectForKey:@"data"];
        self.icon = [decoder decodeObjectForKey:@"icon"];
        self.summary = [decoder decodeObjectForKey:@"summary"];
    }
    return self;
}

+ (WeatherHourly *)instanceFromDictionary:(NSDictionary *)aDictionary {
    WeatherHourly *instance = [[WeatherHourly alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {
    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    @try {
        [self setValuesForKeysWithDictionary:aDictionary];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
    @finally {
        
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"data"]) {
        if ([value isKindOfClass:[NSArray class]]) {
            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                Datum *populatedMember = [Datum instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }
            self.data = myMembers;
        }
    } else {
        @try {
            [super setValue:value forKey:key];
        }
        @catch (NSException *exception) {
            NSLog(@"Exception: %@", exception);
        }
        @finally {
            
        }
    }
}


@end
