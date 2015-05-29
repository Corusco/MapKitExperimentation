//
//  ViewController.h
//  MapKitExperimentation
//
//  Created by Justin Huntington on 5/20/15.
//  Copyright (c) 2015 Justin Huntington. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController//

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//@property (nonatomic, strong) CLLocationManager *locationManager;

@end

