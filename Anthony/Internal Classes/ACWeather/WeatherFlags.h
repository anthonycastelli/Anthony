//
//  WeatherFlags.h
//  
//
//  Created by Anthony Castelli on 4/27/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherFlags : NSObject <NSCoding> {
    NSArray *darkskyStations;
    NSArray *isdStations;
    NSArray *lampStations;
    NSArray *sources;
    NSString *units;
    NSString *darkskyUnavailable;
}

@property (nonatomic, copy) NSArray *darkskyStations;
@property (nonatomic, copy) NSArray *isdStations;
@property (nonatomic, copy) NSArray *lampStations;
@property (nonatomic, copy) NSArray *sources;
@property (nonatomic, copy) NSString *units;
@property (nonatomic, copy) NSString *darkskyUnavailable;

+ (WeatherFlags *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
