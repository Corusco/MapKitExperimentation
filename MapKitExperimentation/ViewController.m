//
//  ViewController.m
//  MapKitExperimentation
//
//  Created by Justin Huntington on 5/20/15.
//  Copyright (c) 2015 Justin Huntington. All rights reserved.
//

#define METERS_MILE 1609.344
#define METERS_FEET 3.28084

#import "ViewController.h"


@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic) MKUserLocation *userLocation;
@property(nonatomic) BOOL showsUserLocation;
@property (nonatomic) CLLocationCoordinate2D circleCenter;
@property (nonatomic) BOOL userLocationUpdated;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mapView setShowsUserLocation:YES];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    [self.mapView setDelegate:self];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager startUpdatingLocation];
    
    self.circleCenter = CLLocationCoordinate2DMake(40.7705, 111.8920);
    
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:self.circleCenter radius:1*METERS_MILE];
    
    [self.mapView addOverlay:circle];
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = locations.lastObject;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2*METERS_MILE, 2*METERS_MILE);
    if (!self.userLocationUpdated) {
        [self.mapView setRegion:viewRegion animated:YES];
        self.userLocationUpdated = YES;
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id<MKOverlay>)overlay{
    
    MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithCircle:overlay];
    
    circleRenderer.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
    circleRenderer.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
    circleRenderer.lineWidth = 2;
    
    return circleRenderer;
    
}


@end
