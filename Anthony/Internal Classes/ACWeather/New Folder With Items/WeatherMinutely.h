//
//  WeatherMinutely.h
//  
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherMinutely : NSObject <NSCoding> {
    NSArray *data;
    NSString *icon;
    NSString *summary;
}

@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *summary;

+ (WeatherMinutely *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
