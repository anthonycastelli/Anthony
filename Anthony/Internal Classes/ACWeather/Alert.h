//
//  Alert.h
//  
//
//  Created by Anthony Castelli on 4/27/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alert : NSObject <NSCoding> {
    NSNumber *expires;
    NSString *title;
    NSString *uri;
}

@property (nonatomic, copy) NSNumber *expires;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *uri;

+ (Alert *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
