//
//  HAZCityAirQuality.m
//  AirQuality ObjC
//
//  Created by Jake Haslam on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "HAZCityAirQuality.h"
#import "HAZWeather.h"
#import "HAZPollution.h"

@implementation HAZCityAirQuality

// We are initilizing and returning our HAZCityAirQuality Object with the properties given bellow
- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(HAZWeather *)weather pollution:(HAZPollution *)pollution
{
    
    // Initlizing our super class
    self = [super init];
    // If the superclass is not nill initilize the object with this data
    if (self)
    {
        // looking at the properties from the class with the values passed in from the initiliezers perams
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    // Return that sweet sweet initilized object
    return self;
}

@end

@implementation HAZCityAirQuality (JSONConvertable)

// This is initilizing and returning a HazCityAirQuality Object by accessing values in the dictionary that was passed
- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    
    // We are initilizing the values with their needed types and assign them by parsing into the dictionary at the necessarry keys to access the values we need.
    NSString *city = dictionary[@"city"];
    NSString *state = dictionary[@"state"];
    NSString *country = dictionary[@"country"];
    NSDictionary *currentInfo = dictionary[@"current"];
    
    // We are accessing our initWithDictionary initializers for the Weather and Pollution objects to initilize and assign the needed values for the designated initializer We pass in the dictionaries found at the keys "weather" and "pollution"
    HAZWeather *weather = [[HAZWeather new] initWithDictionary:currentInfo[@"weather"]];
    HAZPollution *pollution = [[HAZPollution new] initWithDictionary:currentInfo[@"pollution"]];
    
    // We are returning an instance of the class by calling the designated initializer and passing in the values pulled from the dictionary
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}

@end
