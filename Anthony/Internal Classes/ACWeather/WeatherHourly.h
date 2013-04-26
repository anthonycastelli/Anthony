//
//  WeatherHourly.h
//  
//
//  Created by Anthony Castelli on 4/26/2013.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherHourly : NSObject <NSCoding> {
    NSArray *data;
    NSString *icon;
    NSString *summary;
}

@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *summary;

+ (WeatherHourly *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
