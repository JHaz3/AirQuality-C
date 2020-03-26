//
//  HAZPollution.h
//  AirQuality ObjC
//
//  Created by Jake Haslam on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HAZPollution : NSObject

@property(nonatomic, readonly) NSInteger airQualityIndex;

-(instancetype)initWithAQI:(NSInteger)aqi;

@end

@interface HAZPollution (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
