//
//  Forecast.h
//  Anthony
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Forecast : NSObject <NSCoding> {
    NSNumber *cond;
    NSString *date;
    NSNumber *high;
    NSNumber *low;
    NSNumber *rain;
    NSNumber *snow;
    NSString *sunrise;
    NSString *sunset;
    NSNumber *uv;
    NSString *wdir;
    NSNumber *wspeed;
}

@property (nonatomic, copy) NSNumber *cond;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSNumber *high;
@property (nonatomic, copy) NSNumber *low;
@property (nonatomic, copy) NSNumber *rain;
@property (nonatomic, copy) NSNumber *snow;
@property (nonatomic, copy) NSString *sunrise;
@property (nonatomic, copy) NSString *sunset;
@property (nonatomic, copy) NSNumber *uv;
@property (nonatomic, copy) NSString *wdir;
@property (nonatomic, copy) NSNumber *wspeed;

+ (Forecast *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
