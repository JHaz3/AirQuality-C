//
//  HAZWeather.h
//  AirQuality ObjC
//
//  Created by Jake Haslam on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HAZWeather : NSObject

// Making our properties let temp: Int etc...
@property (nonatomic, readonly) NSInteger temperature;
@property (nonatomic, readonly) NSInteger humidity;
@property (nonatomic, readonly) NSInteger windSpeed;

// Creating a method signature that takes in temperature, humidity, windSpeed
- (instancetype)initWithWeatherInfo:(NSInteger)temperature
                          humidity:(NSInteger)humidity
                         windSpeed:(NSInteger)windSpeed;

@end

@interface HAZWeather (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary <NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
