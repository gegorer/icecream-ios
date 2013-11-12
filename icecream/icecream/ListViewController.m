//
//  FirstViewController.m
//  icecream
//
//  Created by Shao Hang Kao on 2013/11/10.
//  Copyright (c) 2013年 gegorer. All rights reserved.
//

#import "ListViewController.h"
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
    stores = [[Stores singleton] fetchWithKeyword:nil];
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

@end
