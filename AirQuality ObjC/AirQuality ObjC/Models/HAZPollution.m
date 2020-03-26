//
//  HAZPollution.m
//  AirQuality ObjC
//
//  Created by Jake Haslam on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "HAZPollution.h"

@implementation HAZPollution

- (instancetype)initWithAQI:(NSInteger)aqi
{
    self = [super init];
    if (self)
    {
        _airQualityIndex = aqi;
    }
    return self;
}

@end

@implementation HAZPollution (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger aqi = [dictionary[@"aqius"] intValue];
    
    return [self initWithAQI:aqi];
}

@end
