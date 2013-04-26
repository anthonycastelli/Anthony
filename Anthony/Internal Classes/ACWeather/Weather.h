//
//  Weather.h
//  Anthony
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Forecast.h"

@interface Weather : NSObject <NSCoding> {
    NSNumber *cloud;
    NSNumber *cond;
    NSString *dew;
    NSNumber *feel;
    NSArray *forecast;
    NSNumber *humid;
    NSString *obtime;
    NSNumber *temp;
    NSString *time;
    NSNumber *timez;
    NSNumber *uv;
    NSString *wdir;
    NSNumber *wspeed;
}

@property (nonatomic, copy) NSNumber *cloud;
@property (nonatomic, copy) NSNumber *cond;
@property (nonatomic, copy) NSString *dew;
@property (nonatomic, copy) NSNumber *feel;
@property (nonatomic, copy) NSArray *forecast;
@property (nonatomic, copy) NSNumber *humid;
@property (nonatomic, copy) NSString *obtime;
@property (nonatomic, copy) NSNumber *temp;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSNumber *timez;
@property (nonatomic, copy) NSNumber *uv;
@property (nonatomic, copy) NSString *wdir;
@property (nonatomic, copy) NSNumber *wspeed;

+ (Weather *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
