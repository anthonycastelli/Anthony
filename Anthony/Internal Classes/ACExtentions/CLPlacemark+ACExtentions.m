//
//  CLPlacemark+ACExtentions.m
//  Anthony
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "CLPlacemark+ACExtentions.h"

@interface CLPlacemark (Private)
- (NSDictionary *)nameAbbreviations;
@end

@implementation CLPlacemark (ACExtentions)

- (NSString *)shortState {
    NSString *state = [self.administrativeArea lowercaseString];
    if (state.length == 0)
        return nil;
    
    return [self.nameAbbreviations objectForKey:state];
}

- (NSDictionary *)nameAbbreviations {
    
    static NSDictionary *nameAbbreviations = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        nameAbbreviations = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"AL", @"alabama",
                             @"AK", @"alaska",
                             @"AZ", @"arizona",
                             @"AR", @"arkansas",
                             @"CA", @"california",
                             @"CO", @"colorado",
                             @"CT", @"connecticut",
                             @"DE", @"delaware",
                             @"DC", @"district of columbia",
                             @"FL", @"florida",
                             @"GA", @"georgia",
                             @"HI", @"hawaii",
                             @"ID", @"idaho",
                             @"IL", @"illinois",
                             @"IN", @"indiana",
                             @"IA", @"iowa",
                             @"KS", @"kansas",
                             @"KY", @"kentucky",
                             @"LA", @"louisiana",
                             @"ME", @"maine",
                             @"MD", @"maryland",
                             @"MA", @"massachusetts",
                             @"MI", @"michigan",
                             @"MN", @"minnesota",
                             @"MS", @"mississippi",
                             @"MO", @"missouri",
                             @"MT", @"montana",
                             @"NE", @"nebraska",
                             @"NV", @"nevada",
                             @"NH", @"new hampshire",
                             @"NJ", @"new jersey",
                             @"NM", @"new mexico",
                             @"NY", @"new york",
                             @"NC", @"north carolina",
                             @"ND", @"north dakota",
                             @"OH", @"ohio",
                             @"OK", @"oklahoma",
                             @"OR", @"oregon",
                             @"PA", @"pennsylvania",
                             @"RI", @"rhode island",
                             @"SC", @"south carolina",
                             @"SD", @"south dakota",
                             @"TN", @"tennessee",
                             @"TX", @"texas",
                             @"UT", @"utah",
                             @"VT", @"vermont",
                             @"VA", @"virginia",
                             @"WA", @"washington",
                             @"WV", @"west virginia",
                             @"WI", @"wisonsin",
                             @"WY", @"wyoming",
                             nil];
    });
    
    return nameAbbreviations;
}

@end
