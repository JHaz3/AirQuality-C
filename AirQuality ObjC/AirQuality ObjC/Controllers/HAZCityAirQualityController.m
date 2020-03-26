//
//  HAZCityAirQualityController.m
//  AirQuality ObjC
//
//  Created by Jake Haslam on 3/25/20.
//  Copyright © 2020 RYAN GREENBURG. All rights reserved.
//

#import "HAZCityAirQualityController.h"
#import "HAZCityAirQuality.h"

// Crating our URL Components that we will put together further bellow
static NSString *const baseURLString = @"https://api.airvisual.com/";
static NSString *const version = @"v2";
static NSString *const countryComponent = @"countries";
static NSString *const stateComponent = @"states";
static NSString *const cityComponent = @"cities";
static NSString *const cityDetailsComponent = @"city";
static NSString *const apiKey = @"a0849578-608d-4b2d-a7cc-9c11e6596d91";

@implementation HAZCityAirQualityController

+ (void)fetchSupportedContries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:version];
    NSURL *countryURL = [versionURL URLByAppendingPathComponent:countryComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem new] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents new] initWithURL:countryURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            NSDictionary *topLevelObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *dataDictionary = topLevelObject[@"data"];
            NSMutableArray *countries = [NSMutableArray new];
            for (NSDictionary *countryDictionary in dataDictionary)
            {
                NSString *country = [[NSString alloc] initWithString:countryDictionary[@"country"]];
                // NSString *country = countryDictionary[@"country"];
                [countries addObject:country];
            }
            completion(countries);
        }
    }] resume];
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:version];
    NSURL *statesURL = [versionURL URLByAppendingPathComponent:stateComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *countryQuery = [[NSURLQueryItem new] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem new] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents new] initWithURL:statesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            NSDictionary *topLevelObject  = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *dataDictionary = topLevelObject[@"data"];
            NSMutableArray *states = [NSMutableArray new];
            for (NSDictionary *stateDictionary in dataDictionary)
            {
                NSString *state = stateDictionary[@"state"];
                [states addObject:state];
            }
            completion(states);
        }
    }] resume];
}

+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:version];
    NSURL *citiesURL= [versionURL URLByAppendingPathComponent:cityComponent];
    
    NSMutableArray <NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *stateQuery = [[NSURLQueryItem new] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem new] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem new] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents new] initWithURL:citiesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            NSDictionary *topLevelObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *dataDictionary = topLevelObject[@"data"];
            NSMutableArray *cities = [NSMutableArray new];
            for (NSDictionary *cityDictionary in dataDictionary)
            {
                NSString *city = cityDictionary[@"city"];
                [cities addObject:city];
            }
            completion(cities);
        }
    }] resume];
}

+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(HAZCityAirQuality * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:version];
    NSURL *cityURL = [versionURL URLByAppendingPathComponent:cityDetailsComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *cityQuery = [[NSURLQueryItem new] initWithName:@"city" value:city];
    NSURLQueryItem *stateQuery = [[NSURLQueryItem new] initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem new] initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem new] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:cityQuery];
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents new] initWithURL:cityURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            NSDictionary *topLevelObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *dataDictionary = topLevelObject[@"data"];
            
            HAZCityAirQuality *cityAirQualityIndex = [[HAZCityAirQuality new] initWithDictionary:dataDictionary];
            completion(cityAirQualityIndex);
        }
    }] resume];
}

@end
