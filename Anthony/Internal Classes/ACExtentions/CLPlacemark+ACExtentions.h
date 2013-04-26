//
//  CLPlacemark+ACExtentions.h
//  Anthony
//
//  Created by Anthony Castelli on 4/26/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLPlacemark (ACExtentions)

/*
 Converts the long state name i.e. Nevada to its short code NV
 */
- (NSString *)shortState;

@end
