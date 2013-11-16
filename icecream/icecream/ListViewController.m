//
//  FirstViewController.m
//  icecream
//
//  Created by Shao Hang Kao on 2013/11/10.
//  Copyright (c) 2013年 gegorer. All rights reserved.
//

#import "ListViewController.h"
#import "MapViewController.h"
#import "Stores.h"
#import "Store.h"

@interface ListViewController ()
@end

@implementation ListViewController

@synthesize storeList;
@synthesize searchBar;

NSArray *stores;

- (void)viewDidLoad
{
    [super viewDidLoad];
    stores = [[Stores singleton] fetchWithKeyword:@"台北"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"storeItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    Store *store = [stores objectAtIndex:indexPath.row];
    cell.textLabel.text = [store name];
    cell.detailTextLabel.text = [store addr];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Store *store = [stores objectAtIndex:indexPath.row];
    MapViewController *vc = (MapViewController *)[self.tabBarController.viewControllers objectAtIndex:1];
    [vc centerAtLat:store.lat andLon:store.lon];
    self.tabBarController.selectedViewController = vc;
}

@end
