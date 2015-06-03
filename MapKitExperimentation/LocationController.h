//
//  LocationController.h
//  MapKitExperimentation
//
//  Created by Justin Huntington on 5/28/15.
//  Copyright (c) 2015 Justin Huntington. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h> 


@interface LocationController : NSObject

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, readonly) CLLocationDegrees *cacheLocationLatitude;
@property (nonatomic, readonly) CLLocationDegrees *cacheLocationLongitude;
@property (nonatomic, readonly) CLLocation *currentUserLocation;

+ (instancetype)sharedInstance;

- (CLLocationCoordinate2D)getRandomizedSearchCircle:(CLLocation *)cacheLocation;

- (BOOL)canCompleteCache;

@end
