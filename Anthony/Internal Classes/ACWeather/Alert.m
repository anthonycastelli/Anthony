//
//  Alert.m
//  
//
//  Created by Anthony Castelli on 4/27/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "Alert.h"

@implementation Alert

@synthesize expires;
@synthesize title;
@synthesize uri;

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.expires forKey:@"expires"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.uri forKey:@"uri"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        self.expires = [decoder decodeObjectForKey:@"expires"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.uri = [decoder decodeObjectForKey:@"uri"];
    }
    return self;
}

+ (Alert *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Alert *instance = [[Alert alloc] init];
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

@end
