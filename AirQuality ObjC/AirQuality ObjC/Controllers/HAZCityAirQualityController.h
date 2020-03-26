//
//  HAZCityAirQualityController.h
//  AirQuality ObjC
//
//  Created by Jake Haslam on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HAZCityAirQuality;

NS_ASSUME_NONNULL_BEGIN

@interface HAZCityAirQualityController : NSObject

// We are creating our network call methods that will fetch the varrying data that we will need 
+ (void)fetchSupportedContries:(void (^) (NSArray<NSString *> *_Nullable))completion;

+ (void)fetchSupportedStatesInCountry:(NSString *)country
                           completion:(void (^) (NSArray<NSString *> *_Nullable))completion;
+ (void)fetchSupportedCitiesInState:(NSString *)state
                            country:(NSString *)country
                         completion:(void(^) (NSArray<NSString *> *_Nullable))completion;

+ (void)fetchDataForCity:(NSString *)city
                   state:(NSString *)state
                 country:(NSString *)country
              completion:(void(^) (HAZCityAirQuality *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END
