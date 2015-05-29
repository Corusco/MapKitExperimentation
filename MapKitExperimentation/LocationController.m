//
//  LocationController.m
//  MapKitExperimentation
//
//  Created by Justin Huntington on 5/28/15.
//  Copyright (c) 2015 Justin Huntington. All rights reserved.
//

#define METERS_MILE 1609.344
#define METERS_FEET 3.28084
#define ARC4RANDOM_MAX 0x100

#import "LocationController.h"
#import "ViewController.h"
#import "CacheModel.h"

@interface LocationController () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationDegrees *randomizedCacheLocationLatitude;
@property (nonatomic) CLLocationDegrees *randomizedCacheLocationLongitude;
@property (nonatomic) CLLocation *cacheLocation;

@end

@implementation LocationController

+ (instancetype)sharedInstance
{
    static LocationController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LocationController alloc] init];
        
        sharedInstance.locationManager = [[CLLocationManager alloc] init];
        
        [sharedInstance.locationManager setDelegate:sharedInstance];
        
        CacheModel *currentCache = [CacheModel new];
        
        sharedInstance.cacheLocation = currentCache.cacheLocation;
        
        
        
#pragma - Location Manager Setup
        
        if ([sharedInstance.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
           [sharedInstance.locationManager requestWhenInUseAuthorization];
        }
        
        [sharedInstance.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [sharedInstance.locationManager startUpdatingLocation];
        
    });
    
    return sharedInstance;
}


//Currently being called in: 
- (CLLocationCoordinate2D)getRandomizedSearchCircle:(CLLocation *)cacheLocation {
    
    CLLocationDegrees randomizedCacheLatitude = cacheLocation.coordinate.latitude + (((float)arc4random_uniform(2)-.3))/ARC4RANDOM_MAX;
    CLLocationDegrees randomizedCacheLongitude = cacheLocation.coordinate.longitude + (((float)arc4random_uniform(2)-.3))/ARC4RANDOM_MAX;
    CLLocationCoordinate2D randomizedCircleCenter = CLLocationCoordinate2DMake(randomizedCacheLatitude, randomizedCacheLongitude);
    
    return randomizedCircleCenter;
    
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = locations.lastObject;
    
    CLLocationDistance distance = [location distanceFromLocation:self.cacheLocation];
    NSLog(@"%f", distance);
    
    if (distance < 10) {
        NSLog(@"Congratulations");
        
    }
}
@end
