//
//  ACWeatherViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/25/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACWeatherViewController.h"
#import "CLPlacemark+ACExtentions.h"
#import "ACWeather.h"
#import "ACCurrentCell.h"
#import "ACForecastCell.h"

@interface ACWeatherViewController () <CLLocationManagerDelegate, ACWeatherDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSDictionary *weatherData;

- (void)animateView:(UIView *)view toPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;
- (void)configureCurrentCell:(ACCurrentCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)configureForecastCell:(ACForecastCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation ACWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager setDelegate:self];
    [self.locationManager startUpdatingLocation]; // Normally I would check for 'locationServicesEnabled' but for this purpose i'll assume its active
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    
}

#pragma mark - Location

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    NSString *latitiude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    NSString *longitiude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks lastObject];
            self.location = [NSString stringWithFormat:@"%@, %@", placemark.locality, placemark.shortState];
            [[ACWeather currentWeather] setDelegate:self];
            [[ACWeather currentWeather] getWeatherForLatitude:latitiude andLongitude:longitiude];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
    [manager stopUpdatingLocation];
}

#pragma mark - Weather 

- (void)weather:(ACWeather *)weather didReceiveForecast:(NSDictionary *)forecast {
    self.weatherData = forecast;
    //NSLog(@"%@", forecast);
    [self.tableView reloadData];
}

#pragma mark - Animations

- (void)animateView:(UIView *)view toPoint:(CGPoint)point withDelay:(NSTimeInterval)delay {
    [self performBlock:^{
        NSString *keyPath = @"position.x";
        id toValue = [NSNumber numberWithFloat:point.x];
        ACBounceAnimation *bounce = [ACBounceAnimation animationWithKeyPath:keyPath];
        bounce.fromValue = [NSNumber numberWithFloat:view.center.x];
        bounce.toValue = toValue;
        bounce.duration = 0.6f;
        bounce.numberOfBounces = 4;
        bounce.shouldOvershoot = YES;
        
        [view.layer addAnimation:bounce forKey:@"bounce"];
        [view.layer setValue:toValue forKeyPath:keyPath];
    } afterDelay:delay];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) return 120.0f;
    return 96.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ACCurrentCell *current = (ACCurrentCell *)[tableView dequeueReusableCellWithIdentifier:@"CurrentCell" forIndexPath:indexPath];
        [self configureCurrentCell:current atIndexPath:indexPath];
        return current;
    }
    ACForecastCell *forecast = (ACForecastCell *)[tableView dequeueReusableCellWithIdentifier:@"ForecastCell" forIndexPath:indexPath];
    [self configureForecastCell:forecast atIndexPath:indexPath];
    return forecast;
}

- (void)configureCurrentCell:(ACCurrentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell.currentTemp.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [cell.currentTemp.layer setShadowRadius:3.0f];
    [cell.currentTemp.layer setShadowOpacity:0.3f];
    [cell.currentTemp.layer setShadowOffset:CGSizeMake(0, 1)];
    [cell.currentTemp.layer setMasksToBounds:NO];
    [cell.currentTemp setClipsToBounds:NO];
    
    Weather *weather = [Weather instanceFromDictionary:self.weatherData];
    [cell setForecastColor:ACForecastColorGreen];
    [cell.location setText:self.location];
    [cell.currentTemp setText:[NSString stringWithFormat:@"%@˚", weather.temp]];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setDateFormat:@"EEEE"];
    NSString *dayName = [df stringFromDate:[NSDate date]];
    [cell.day setText:dayName];
}

- (void)configureForecastCell:(ACForecastCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Weather *weather = [Weather instanceFromDictionary:self.weatherData];
    Forecast *forcast = weather.forecast[indexPath.row];
    
    [cell setForecastColor:ACForecastDayColorBlue];
    
    [cell.temp.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [cell.temp.layer setShadowRadius:3.0f];
    [cell.temp.layer setShadowOpacity:0.3f];
    [cell.temp.layer setShadowOffset:CGSizeMake(0, 1)];
    [cell.temp.layer setMasksToBounds:NO];
    [cell.temp setClipsToBounds:NO];
    
    [cell.day.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [cell.day.layer setShadowRadius:1.5f];
    [cell.day.layer setShadowOpacity:0.3f];
    [cell.day.layer setShadowOffset:CGSizeMake(0, 1)];
    [cell.day.layer setMasksToBounds:NO];
    [cell.day setClipsToBounds:NO];
    
    [cell.temp setText:[NSString stringWithFormat:@"%@˚", forcast.high]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:forcast.date];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setDateFormat:@"EEEE"];
    NSString *dayName = [df stringFromDate:date];
    [cell.day setText:dayName];
}

@end
