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

@interface MapViewController ()

@end

@implementation MapViewController {
    GMSMapView *mapView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:25.1
                                                            longitude:121.5
                                                                 zoom:13];
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
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
