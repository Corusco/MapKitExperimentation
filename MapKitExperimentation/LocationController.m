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

@interface LocationController () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationDegrees *randomizedCacheLocationLatitude;
@property (nonatomic) CLLocationDegrees *randomizedCacheLocationLongitude;


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
        
#pragma - Location Manager Setup
        
        if ([sharedInstance.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
           [sharedInstance.locationManager requestWhenInUseAuthorization];
        }
        
        [sharedInstance.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [sharedInstance.locationManager startUpdatingLocation];
        
    });
    
    
                 
    return sharedInstance;
}



- (CLLocationCoordinate2D)getRandomizedSearchCircle:(CLLocationCoordinate2D *)cacheLocation {
    
    CLLocationDegrees randomizedCacheLatitude = cacheLocation->latitude + (((float)arc4random_uniform(2)-.3))/ARC4RANDOM_MAX;
    CLLocationDegrees randomizedCacheLongitude = cacheLocation->longitude + (((float)arc4random_uniform(2)-.3))/ARC4RANDOM_MAX;
    CLLocationCoordinate2D randomizedCircleCenter = CLLocationCoordinate2DMake(randomizedCacheLatitude, randomizedCacheLongitude);
    
    return randomizedCircleCenter;
    
}

@end
