//
//  FirstViewController.h
//  icecream
//
//  Created by Shao Hang Kao on 2013/11/10.
//  Copyright (c) 2013年 gegorer. All rights reserved.
//

#import <CoreLocation/CLLocationManagerDelegate.h>
#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate>

@property (nonatomic, retain) IBOutlet UITableView *storeList;
@property (nonatomic, retain) IBOutlet UISearchBar *storeSearchBar;

@end
