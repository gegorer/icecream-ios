//
//  SecondViewController.m
//  icecream
//
//  Created by Shao Hang Kao on 2013/11/10.
//  Copyright (c) 2013年 gegorer. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Stores.h"
#import "Store.h"

#define DEFAULT_ZOOM 14

@interface MapViewController ()

@end

@implementation MapViewController {
    GMSMapView *mapView;
    GMSCameraPosition *camera;
    double centerLat;
    double centerLon;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (camera == nil) {
        camera = [GMSCameraPosition cameraWithLatitude:25.1
                                             longitude:121.5
                                                  zoom:DEFAULT_ZOOM];
    }

    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    // TODO: load async
    NSArray *stores = [[Stores singleton] fetchWithKeyword:nil];
    for (int i=0; i<[stores count]; i++) {
        Store *store = [stores objectAtIndex:i];
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([store lat], [store lon]);
        marker.title = [store name];
        marker.snippet = [store addr];
        marker.map = mapView;
        
        if (marker.position.latitude == centerLat && marker.position.longitude == centerLon) {
            mapView.selectedMarker = marker;
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) centerAtLat:(double)aLat andLon:(double)aLon {

    centerLat = aLat;
    centerLon = aLon;

    camera = [GMSCameraPosition cameraWithLatitude:aLat
                                         longitude:aLon
                                              zoom:DEFAULT_ZOOM];

    if (mapView == nil) {
        return;
    }

    mapView.camera = camera;
    
    for (int i=0; i<[mapView.markers count]; i++) {
        GMSMarker *marker = (GMSMarker *)[mapView.markers objectAtIndex:i];
        if (marker.position.latitude == centerLat && marker.position.longitude == centerLon) {
            mapView.selectedMarker = marker;
            break;
        }
    }
}


@end
