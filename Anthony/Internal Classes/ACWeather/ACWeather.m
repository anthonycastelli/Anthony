//
//  ACWeather.h
//  Drizzle
//
//  Created by Anthony on 5/1/12.
//  Copyright (c) 2012 Tapbits. All rights reserved.
//

#import "ACWeather.h"

static NSString *apiKey = @"6e91c402da114c92f56b6de260b19d08";

@implementation ACWeather

+ (ACWeather *)currentWeather {
    static dispatch_once_t pred;
    static ACWeather *currentWeather = nil;
    dispatch_once(&pred, ^{
        currentWeather = [[self alloc] init];
    });
    return currentWeather;
}

- (void)getWeatherForLatitude:(NSString *)latitude andLongitude:(NSString *)longitude {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.forecast.io/forecast/%@/%@,%@", apiKey, latitude, longitude]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        self.receivedData = [[NSMutableData alloc] init];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    } else {
        NSLog(@"Connection to the weather station failed");
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.receivedData setLength:0];
    NSLog(@"Connected to the weather station");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Succeeded! Received %d bytes of data", [self.receivedData length]);
    
    NSError *error = nil;
    NSDictionary *weather = [NSJSONSerialization JSONObjectWithData:self.receivedData options:kNilOptions error:&error];

    if ([self.delegate respondsToSelector:@selector(weather:didReceiveForecast:)]) {
        [self.delegate performSelector:@selector(weather:didReceiveForecast:) withObject:nil withObject:weather];
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
