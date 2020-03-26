//
//  HAZWeather.m
//  AirQuality ObjC
//
//  Created by Jake Haslam on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//



#import "HAZWeather.h"

@implementation HAZWeather

// Initilizing and returning a Weather Object with the properties given
- (instancetype)initWithWeatherInfo:(NSInteger)temperature humidity:(NSInteger)humidity windSpeed:(NSInteger)windSpeed
{
    self = [super init];
    if (self)
    {
        _temperature = temperature;
        _humidity = humidity;
        _windSpeed = windSpeed;
    }
    return self;
}

@end

@implementation HAZWeather (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger temperature = [dictionary[@"tp"] intValue];
    NSInteger humidity = [dictionary[@"hu"] intValue];
    NSInteger windSpeed = [dictionary[@"ws"] intValue];
    
    return [self initWithWeatherInfo:temperature humidity:humidity windSpeed:windSpeed];
}

@end
