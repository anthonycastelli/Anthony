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
#import "Datum.h"

@interface ACWeatherViewController () <CLLocationManagerDelegate, ACWeatherDelegate>
@property (nonatomic, assign) BOOL refreshed;
@property (nonatomic, retain) UIRefreshControl *refreshControl;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSDictionary *weatherData;

- (void)getWeather;
- (void)animateViewsIn;
- (void)animateViewsOut;
- (void)animateView:(UIView *)view toPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;
- (void)configureCurrentCell:(ACCurrentCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)configureForecastCell:(ACForecastCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (NSString *)pickLoadingString;

@end

@implementation ACWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Setup the swipe gesture
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipe];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self getWeather];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self animateViewsIn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self animateViewsOut];
    [self performBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    } afterDelay:0.2];
}

- (void)getWeather {
    [self.refreshControl beginRefreshing];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.pickLoadingString];
    [self.refreshControl setAttributedTitle:string];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager setDelegate:self];
    [self.locationManager startUpdatingLocation]; // Normally I would check for 'locationServicesEnabled' but for this purpose i'll assume its active
    
    self.refreshed = NO;
}

- (void)handleRefresh:(UIRefreshControl *)control {
    [self getWeather];
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
            [self.refreshControl endRefreshing];
            // Set the refresh controls string to nil so we dont see the old message
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@""];
            [self.refreshControl setAttributedTitle:string];
        }
    }];
    [manager stopUpdatingLocation];
}

#pragma mark - Weather 

- (void)weather:(ACWeather *)weather didReceiveForecast:(NSDictionary *)forecast {
    self.weatherData = forecast;
    [self.tableView reloadData];
    
    self.refreshed = YES; // Used to animate the cells after the weather data is returned
    
    // Delays the endRefreshing to make the loading string easier to read
    [self performBlock:^{
        [self.refreshControl endRefreshing];
        // Set the refresh controls string to nil so we dont see the old message
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@""];
        [self.refreshControl setAttributedTitle:string];
    } afterDelay:1];
}

#pragma mark - Animations

- (void)animateViewsIn {
    [self animateView:self.backButton toPoint:CGPointMake(30, 30) withDelay:0.3];
    [self animateView:self.weather toPoint:CGPointMake(160, 30) withDelay:0.34];
}

- (void)animateViewsOut {
    [self animateView:self.backButton toPoint:CGPointMake(350, 30) withDelay:0.03];
    [self animateView:self.weather toPoint:CGPointMake(480, 30) withDelay:0.0];
    
    ACCurrentCell *current = (ACCurrentCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [current bounceView:current.background InToPoint:CGPointMake(480, 60) withDelay:0.0];
    [current bounceView:current.location InToPoint:CGPointMake(566, 21) withDelay:0.05];
    [current bounceView:current.condtionImage InToPoint:CGPointMake(480, 60) withDelay:0.1];
    [current bounceView:current.currentTemp InToPoint:CGPointMake(377, 28) withDelay:0.15];
    [current bounceView:current.highLow InToPoint:CGPointMake(377, 50) withDelay:0.20];
    [current bounceView:current.condition InToPoint:CGPointMake(377, 65) withDelay:0.25];
    [current bounceView:current.day InToPoint:CGPointMake(377, 90) withDelay:0.30];
    
    ACForecastCell *forecastOne = (ACForecastCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [forecastOne bounceView:forecastOne.background InToPoint:CGPointMake(480, 45) withDelay:0.03];
    [forecastOne bounceView:forecastOne.condition InToPoint:CGPointMake(372, 45) withDelay:0.05];
    [forecastOne bounceView:forecastOne.temp InToPoint:CGPointMake(480, 45) withDelay:0.07];
    [forecastOne bounceView:forecastOne.day InToPoint:CGPointMake(571, 45) withDelay:0.09];
    
    ACForecastCell *forecastTwo = (ACForecastCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [forecastTwo bounceView:forecastTwo.background InToPoint:CGPointMake(480, 45) withDelay:0.05];
    [forecastTwo bounceView:forecastTwo.condition InToPoint:CGPointMake(372, 45) withDelay:0.07];
    [forecastTwo bounceView:forecastTwo.temp InToPoint:CGPointMake(480, 45) withDelay:0.09];
    [forecastTwo bounceView:forecastTwo.day InToPoint:CGPointMake(571, 45) withDelay:0.10];
    
    ACForecastCell *forecastThree = (ACForecastCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    [forecastThree bounceView:forecastThree.background InToPoint:CGPointMake(480, 45) withDelay:0.07];
    [forecastThree bounceView:forecastThree.condition InToPoint:CGPointMake(372, 45) withDelay:0.09];
    [forecastThree bounceView:forecastThree.temp InToPoint:CGPointMake(480, 45) withDelay:0.11];
    [forecastThree bounceView:forecastThree.day InToPoint:CGPointMake(571, 45) withDelay:0.12];
    
    ACForecastCell *forecastFour = (ACForecastCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    [forecastFour bounceView:forecastFour.background InToPoint:CGPointMake(480, 45) withDelay:0.08];
    [forecastFour bounceView:forecastFour.condition InToPoint:CGPointMake(372, 45) withDelay:0.10];
    [forecastFour bounceView:forecastFour.temp InToPoint:CGPointMake(480, 45) withDelay:0.11];
    [forecastFour bounceView:forecastFour.day InToPoint:CGPointMake(571, 45) withDelay:0.12];
}

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
    
    [cell.condition.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [cell.condition.layer setShadowRadius:1.0f];
    [cell.condition.layer setShadowOpacity:0.3f];
    [cell.condition.layer setShadowOffset:CGSizeMake(0, 1)];
    [cell.condition.layer setMasksToBounds:NO];
    [cell.currentTemp setClipsToBounds:NO];
    
    Weather *weather = [Weather instanceFromDictionary:self.weatherData];
    
    // Location from the CLLocaitonManager
    [cell.location setText:self.location];
    
    // Condition
    if ([weather.currently.icon isEqualToString:@"clear-day"]) {
        [cell.condtionImage setImage:[UIImage imageNamed:@"weather_clear"]];
        [cell spinView:cell.condtionImage withDuration:80.0f andRotations:1.0f repeat:YES];
        
    } else if ([weather.currently.icon isEqualToString:@"clear-night"]) {
        [cell.condtionImage setImage:[UIImage imageNamed:@"weather_clear_night"]];
        
    } else if ([weather.currently.icon isEqualToString:@"rain"]) {
        [cell.condtionImage setImage:[UIImage imageNamed:@"weather_rainy"]];
        
    } else if ([weather.currently.icon isEqualToString:@"snow"]) {
        [cell.condtionImage setImage:[UIImage imageNamed:@"weather_snowy"]];
        
    } else if ([weather.currently.icon isEqualToString:@"thunderstorm"]) {
        [cell.condtionImage setImage:[UIImage imageNamed:@"weather_thunder_storm"]];
        
    } else if ([weather.currently.icon isEqualToString:@"cloudy"]) {
        [cell.condtionImage setImage:[UIImage imageNamed:@"weather_cloudy"]];
        
    } else if ([weather.currently.icon isEqualToString:@"partly-cloudy-day"]) {
        [cell.condtionImage setImage:[UIImage imageNamed:@"weather_partly_cloudy"]];
        
    } else if ([weather.currently.icon isEqualToString:@"partly-cloudy-night"]) {
        [cell.condtionImage setImage:[UIImage imageNamed:@"weather_partly_cloudy_night"]];
    
    } else if ([weather.currently.icon isEqualToString:@"fog"]) {
        [cell.condtionImage setImage:[UIImage imageNamed:@"weather_overcast"]];
        
    } else {
        [cell.condtionImage setImage:[UIImage imageNamed:@"weather_unknown"]];
    }
    
    // Temprature Formatter
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMaximumFractionDigits:0];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
    
    // background color based on the temprature
    float currentTemp = [[numberFormatter stringFromNumber:weather.currently.temperature] floatValue];
    if (currentTemp >= -100 && currentTemp <= 32) [cell setForecastColor:ACForecastColorBlue];
    else if (currentTemp >= 33 && currentTemp <= 50) [cell setForecastColor:ACForecastColorGreen];
    else if (currentTemp >= 51 && currentTemp <= 70) [cell setForecastColor:ACForecastColorYellow];
    else if (currentTemp >= 71 && currentTemp <= 200) [cell setForecastColor:ACForecastColorOrange];
    
    // Current Temprature
    [cell.currentTemp setText:[NSString stringWithFormat:@"%@˚", [numberFormatter stringFromNumber:weather.currently.temperature] ?: @""]];
    
    // High and Low temp
    Datum *data = weather.daily.data[0];
    [cell.highLow setText:[NSString stringWithFormat:@"%@˚ / %@˚", [numberFormatter stringFromNumber:data.temperatureMin] ?: @"", [numberFormatter stringFromNumber:data.temperatureMax] ?: @""]];
    
    // Condition
    [cell.condition setText:weather.currently.summary];
    
    // Today's day name
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setDateFormat:@"EEEE"];
    NSString *dayName = [df stringFromDate:[NSDate date]];
    [cell.day setText:dayName];
    
    // Animations
    if (self.refreshed) {
        [cell bounceView:cell.background InToPoint:CGPointMake(160, 60) withDelay:0.0];
        [cell bounceView:cell.currentTemp InToPoint:CGPointMake(57, 28) withDelay:0.3];
        [cell bounceView:cell.highLow InToPoint:CGPointMake(57, 50) withDelay:0.4];
        [cell bounceView:cell.condition InToPoint:CGPointMake(57, 65) withDelay:0.5];
        [cell bounceView:cell.day InToPoint:CGPointMake(57, 98) withDelay:0.6];
        [cell bounceView:cell.condtionImage InToPoint:CGPointMake(160, 60) withDelay:0.7];
        [cell bounceView:cell.location InToPoint:CGPointMake(246, 21) withDelay:0.8];
    }
}

- (void)configureForecastCell:(ACForecastCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Weather *weather = [Weather instanceFromDictionary:self.weatherData];
    Datum *datum = weather.daily.data[indexPath.row];
    
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
    
    // Condition
    if ([datum.icon isEqualToString:@"clear-day"]) {
        [cell.condition setImage:[UIImage imageNamed:@"weather_clear_small"]];
        
    } else if ([datum.icon isEqualToString:@"clear-night"]) {
        [cell.condition setImage:[UIImage imageNamed:@"weather_clear_night_small"]];
        
    } else if ([datum.icon isEqualToString:@"rain"]) {
        [cell.condition setImage:[UIImage imageNamed:@"weather_rainy_small"]];
        
    } else if ([datum.icon isEqualToString:@"snow"]) {
        [cell.condition setImage:[UIImage imageNamed:@"weather_snowy_small"]];
        
    } else if ([datum.icon isEqualToString:@"thunderstorm"]) {
        [cell.condition setImage:[UIImage imageNamed:@"weather_thunder_storm_small"]];
        
    } else if ([datum.icon isEqualToString:@"cloudy"]) {
        [cell.condition setImage:[UIImage imageNamed:@"weather_cloudy_small"]];
        
    } else if ([datum.icon isEqualToString:@"partly-cloudy-day"]) {
        [cell.condition setImage:[UIImage imageNamed:@"weather_partly_cloudy_small"]];
        
    } else if ([datum.icon isEqualToString:@"partly-cloudy-night"]) {
        [cell.condition setImage:[UIImage imageNamed:@"weather_partly_cloudy_night_small"]];
        
    } else {
        [cell.condition setImage:[UIImage imageNamed:@"weather_unknown_small"]];
    }
    
    // Temprature Formatter
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMaximumFractionDigits:0];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
    
    // Temp
    [cell.temp setText:[NSString stringWithFormat:@"%@˚", [numberFormatter stringFromNumber:datum.temperatureMax] ?: @""]];
    
    // Color
    
    float currentTemp = [[numberFormatter stringFromNumber:datum.temperatureMax] floatValue];
    if (currentTemp >= -100 && currentTemp <= 32) [cell setForecastColor:ACForecastDayColorBlue];
    else if (currentTemp >= 33 && currentTemp <= 50) [cell setForecastColor:ACForecastDayColorGreen];
    else if (currentTemp >= 51 && currentTemp <= 70) [cell setForecastColor:ACForecastDayColorYellow];
    else if (currentTemp >= 71 && currentTemp <= 200) [cell setForecastColor:ACForecastDayColorOrange];
    
    // Day
    NSTimeInterval interval = datum.time.floatValue;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setDateFormat:@"EEEE"];
    NSString *dayName = [df stringFromDate:[NSDate dateWithTimeIntervalSince1970:interval]];
    [cell.day setText:dayName];
    
    // Animations
    if (self.refreshed) {
        if (indexPath.row == 1) {
            [self performBlock:^{
                [cell bounceView:cell.loading InToPoint:CGPointMake(-160, 45) withDelay:0.0];
                [cell bounceView:cell.background InToPoint:CGPointMake(160, 46) withDelay:0.0];
                [cell bounceView:cell.condition InToPoint:CGPointMake(52, 46) withDelay:0.3];
                [cell bounceView:cell.temp InToPoint:CGPointMake(160, 46) withDelay:0.4];
                [cell bounceView:cell.day InToPoint:CGPointMake(251, 44) withDelay:0.5];
            } afterDelay:0.20];
        } else if (indexPath.row == 2) {
            [self performBlock:^{
                [cell bounceView:cell.loading InToPoint:CGPointMake(-160, 45) withDelay:0.0];
                [cell bounceView:cell.background InToPoint:CGPointMake(160, 46) withDelay:0.0];
                [cell bounceView:cell.condition InToPoint:CGPointMake(52, 46) withDelay:0.3];
                [cell bounceView:cell.temp InToPoint:CGPointMake(160, 46) withDelay:0.4];
                [cell bounceView:cell.day InToPoint:CGPointMake(251, 44) withDelay:0.5];
            } afterDelay:0.25];
        } else if (indexPath.row == 3) {
            [self performBlock:^{
                [cell bounceView:cell.loading InToPoint:CGPointMake(-160, 45) withDelay:0.0];
                [cell bounceView:cell.background InToPoint:CGPointMake(160, 46) withDelay:0.0];
                [cell bounceView:cell.condition InToPoint:CGPointMake(52, 46) withDelay:0.3];
                [cell bounceView:cell.temp InToPoint:CGPointMake(160, 46) withDelay:0.4];
                [cell bounceView:cell.day InToPoint:CGPointMake(251, 44) withDelay:0.5];
            } afterDelay:0.30];
        } else if (indexPath.row == 4) {
            [self performBlock:^{
                [cell bounceView:cell.loading InToPoint:CGPointMake(-160, 45) withDelay:0.0];
                [cell bounceView:cell.background InToPoint:CGPointMake(160, 46) withDelay:0.0];
                [cell bounceView:cell.condition InToPoint:CGPointMake(52, 46) withDelay:0.3];
                [cell bounceView:cell.temp InToPoint:CGPointMake(160, 46) withDelay:0.4];
                [cell bounceView:cell.day InToPoint:CGPointMake(251, 44) withDelay:0.5];
            } afterDelay:0.35];
        }
    }
}

#pragma mark - Loading String

- (NSString *)pickLoadingString {
    NSString *notice1 = @"Holding wet finger aloft";
    NSString *notice2 = @"Predicting rain patterns";
    NSString *notice3 = @"Touching the seaweed";
    NSString *notice4 = @"Interfacing with weather ballons";
    NSString *notice5 = @"Consulting knee joint";
    NSString *notice6 = @"Asking the weatherman";
    NSString *notice7 = @"Combining the clouds";
    NSString *notice8 = @"Counting standing cows";
    NSString *notice9 = @"Scanning from the crows nest";
    NSString *notice10 = @"Consulting the oracle";
    NSString *notice11 = @"Gathering observations";
    NSString *notice12 = @"Checking the weather station";
    NSString *notice13 = @"Heckling the thermomenter";
    
    NSArray *noticeArray = @[notice1, notice2, notice3, notice4, notice5, notice6, notice7, notice8, notice9, notice10, notice11, notice12, notice13];
    
    int randomIndex = arc4random() % [noticeArray count];
    NSString *randomString = [noticeArray objectAtIndex:randomIndex];
    
    return randomString;
}

#pragma mark - Refresh the weather via a shake

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        [self getWeather];
    }
}


@end
