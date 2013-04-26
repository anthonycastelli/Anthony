//
//  WeatherFlags.h
//  
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherFlags : NSObject <NSCoding> {
    NSArray *darkskyStations;
    NSArray *isdStations;
    NSArray *lampStations;
    NSArray *metarStations;
    NSArray *sources;
    NSString *units;
}

@property (nonatomic, copy) NSArray *darkskyStations;
@property (nonatomic, copy) NSArray *isdStations;
@property (nonatomic, copy) NSArray *lampStations;
@property (nonatomic, copy) NSArray *metarStations;
@property (nonatomic, copy) NSArray *sources;
@property (nonatomic, copy) NSString *units;

+ (WeatherFlags *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
