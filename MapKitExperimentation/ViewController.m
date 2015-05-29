//
//  ViewController.m
//  MapKitExperimentation
//
//  Created by Justin Huntington on 5/20/15.
//  Copyright (c) 2015 Justin Huntington. All rights reserved.
//

#define METERS_MILE 1609.344
#define METERS_FEET 3.28084
#define ARC4RANDOM_MAX 0x100

#import "ViewController.h"
#import "LocationController.h"


@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic) MKUserLocation *userLocation;
@property (nonatomic) BOOL showsUserLocation;
@property (nonatomic) BOOL userLocationUpdated;
@property (nonatomic) CLLocation *cacheLocation;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    [self.mapView setShowsUserLocation:YES];
    
    [self.mapView setDelegate:self];
    
#pragma - Location Manager Setup
    
    if ([[LocationController sharedInstance].locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [[LocationController sharedInstance].locationManager requestWhenInUseAuthorization];
    }
    
#pragma  - Playing with coordinates, drawing a circle
    
    //make a circle and give it coordinates
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:[[LocationController sharedInstance] getRandomizedSearchCircle:(self.cacheLocation)] radius: .5*METERS_MILE];
    
    
    //add circle overlay to view
    [self.mapView addOverlay:circle];
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = locations.lastObject;
    
    CLLocationDistance distance = [[LocationController sharedInstance].locationManager.location distanceFromLocation:self.cacheLocation];
    NSLog(@"%f", distance);
    
    if (distance < 10) {
        NSLog(@"Congratulations");
        
    }

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2*METERS_MILE, 2*METERS_MILE);
    
    if (!self.userLocationUpdated) {
        [self.mapView setRegion:viewRegion animated:YES];
        self.userLocationUpdated = YES;
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay{
    
    MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithCircle:overlay];
    
    circleRenderer.fillColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    circleRenderer.strokeColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    circleRenderer.lineWidth = 2;
    
    return circleRenderer;
    
}





@end
