//
//  FirstViewController.m
//  icecream
//
//  Created by Shao Hang Kao on 2013/11/10.
//  Copyright (c) 2013年 gegorer. All rights reserved.
//

#import "ECSlidingViewController.h"
#import "ListViewController.h"
#import "MapViewController.h"
#import "Stores.h"
#import "Store.h"

@interface ListViewController ()
@end

@implementation ListViewController

@synthesize storeList;
@synthesize storeSearchBar;

NSArray *stores;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[ListViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StoreMap"];
    }
    self.slidingViewController.shouldAddPanGestureRecognizerToTopViewSnapshot = YES;
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    [self.slidingViewController setAnchorRightPeekAmount:40.0f];
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    stores = [[Stores singleton] fetchWithKeyword:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSource
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

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Store *store = [stores objectAtIndex:indexPath.row];
    MapViewController *vc = (MapViewController *)self.slidingViewController.underLeftViewController;
    if (vc == nil) {
        return;
    }
    [vc centerAtLat:store.lat andLon:store.lon];
    [self.slidingViewController anchorTopViewTo:ECRight];
    //self.tabBarController.selectedViewController = vc;
}

#pragma UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText != nil && ![searchText isEqualToString:@""]) {
        stores = [[Stores singleton] fetchWithKeyword:searchText];
    }
    else {
        stores = [[Stores singleton] fetchWithKeyword:nil];
    }
    [storeList reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
@end
