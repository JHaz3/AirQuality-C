//
//  HAZCityAirQuality.h
//  AirQuality ObjC
//
//  Created by Jake Haslam on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class HAZWeather;
@class HAZPollution;

@interface HAZCityAirQuality : NSObject

@property (nonatomic, copy, readonly) NSString *country;
@property (nonatomic, copy, readonly) NSString *state;
@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) HAZWeather *weather;
@property (nonatomic, copy, readonly) HAZPollution *pollution;

- (instancetype)initWithCity:(NSString *)city
                       state:(NSString *)state
                     country:(NSString *)country
                     weather:(HAZWeather *)weather
                   pollution:(HAZPollution *)pollution;
@end

@interface HAZCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
