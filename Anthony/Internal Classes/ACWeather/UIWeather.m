//
//  UIWeather.m
//  Thermometer
//
//  Created by Anthony on 5/1/12.
//  Copyright (c) 2012 Tapbits. All rights reserved.
//

#import "UIWeather.h"

static NSString *weatherbugAPI = @"A4551663586";
static NSString *apiKey = @"5c7d27335c203458120105";

//World Weather Online
//http://free.worldweatheronline.com/feed/weather.ashx?key=%@&q=%@,%@&fx=no&format=xml
//http://free.worldweatheronline.com/feed/weather.ashx?key=%@&q=%@,%@&fx=no&&num_of_days=5format=xml
//http://free.worldweatheronline.com/feed/weather.ashx?key=%@&q=%@&num_of_days=5&format=xml

//Ouside
//http://outsideweather.appspot.com/aweather?loc=USNV0076&geo=39.483738,-119.804502
//http://outsideweather.appspot.com/aweather?geo=39.483738,-119.804502


// Live Weather
// http://%@.api.wxbug.net/getLiveWeatherRSS.aspx?ACode=%@&lat=%@&long=%@&UnitType=1&OutputType=1

@implementation UIWeather
@synthesize delegate;
@synthesize receivedData;

//http://A4551663586.api.wxbug.net/getLocationsXML.aspx?ACode=A4551663586&SearchString=Perth

- (void)getWeatherForLatitude:(NSString *)latitude andLongitude:(NSString *)longitude {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@.api.wxbug.net/getForecastRSS.aspx?ACode=%@&lat=%@&long=%@&UnitType=0&OutputType=1", weatherbugAPI, weatherbugAPI, latitude, longitude]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        self.receivedData = [[NSMutableData data] retain];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    } else {
        NSLog(@"Connection to the weather station failed");
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

- (void)getWeatherForLatitude:(NSString *)latitude andLongitude:(NSString *)longitude withServerice:(UIWeatherService)service {
    if (service == UIWeatherServiceBugged) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@.api.wxbug.net/getForecastRSS.aspx?ACode=%@&lat=%@&long=%@&UnitType=0&OutputType=1", weatherbugAPI, weatherbugAPI, latitude, longitude]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        buggedConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (worldConnection) {
            self.receivedData = [[NSMutableData data] retain];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        } else {
            NSLog(@"Connection to the weather station failed");
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
    } else if (service == UIWeatherServiceWorld) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://free.worldweatheronline.com/feed/weather.ashx?key=%@&q=%@,%@&fx=no&&num_of_days=5format=xml", apiKey, latitude, longitude]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        worldConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (worldConnection) {
            self.receivedData = [[NSMutableData data] retain];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        } else {
            NSLog(@"Connection to the weather station failed");
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
    } else if (service == UIWeatherServiceOutside) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://outsideweather.appspot.com/aweather?geo=%@,%@", latitude, longitude]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        outsideConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (outsideConnection) {
            self.receivedData = [[NSMutableData data] retain];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        } else {
            NSLog(@"Connection to the weather station failed");
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
    }
}

- (void)getWeatherForLocation:(NSString *)location {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://free.worldweatheronline.com/feed/weather.ashx?key=%@&q=%@&num_of_days=5&format=xml", apiKey, location]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        self.receivedData = [[NSMutableData data] retain];
    } else {
        NSLog(@"Connection to the weather station failed");
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
    [connection release];
    [self.receivedData release];
    
    NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Succeeded! Received %d bytes of data", [self.receivedData length]);
    
    NSDictionary *weather = nil;
    
    if (connection == outsideConnection) {
        NSString *jsonWeather = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
        weather = [jsonWeather objectFromJSONString];
    } else {
        NSError *parseError = nil;
        weather = [XMLReader dictionaryForXMLData:self.receivedData error:&parseError];
    } 

    if ([delegate respondsToSelector:@selector(weather:didReceiveForecast:)]) {
        [delegate performSelector:@selector(weather:didReceiveForecast:) withObject:nil withObject:weather];
    }
    
    [connection release];
    [self.receivedData release];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)dealloc {
    [super dealloc];
}

@end
