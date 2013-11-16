//
//  Stores.m
//  icecream
//
//  Created by Shao Hang Kao on 2013/11/12.
//  Copyright (c) 2013年 gegorer. All rights reserved.
//

#import "Stores.h"
#import "Store.h"
#import "sqlite3.h"

@interface Stores() {
    sqlite3 *database;
    NSMutableArray *stores;
}

- (void) createDatabase;
- (void) fetchData;

@end

@implementation Stores

static Stores *_stores = nil;

+ (Stores *) singleton {
    if (_stores == nil) {
        _stores = [[Stores alloc] init];
    }
    return _stores;
}

- (void) checkData {
    if (stores == nil || [stores count] == 0) {
        [self fetchData];
    }
}

- (NSArray *) fetchWithKeyword:(NSString *)aKeyword andRef:(CLLocation *)aLoc{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i=0; i<[stores count]; i++) {
        Store *store = [stores objectAtIndex:i];
        if (aKeyword != nil) {
            BOOL match = NO;
            NSRange range = [[store name] rangeOfString:aKeyword];
            if (range.location != NSNotFound) {
                match = YES;
            }
            if (!match) {
                range = [[store addr] rangeOfString:aKeyword];
            }
            if (range.location != NSNotFound) {
                match = YES;
            }
            if (!match)
                continue;
        }
        [array addObject: store];
    }
    
    NSArray *sortedArray = nil;
    if (aLoc != nil) {
        sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
            Store *storeA = (Store *)a;
            Store *storeB = (Store *)b;
            CLLocation *locA = [[CLLocation alloc] initWithLatitude:storeA.lat longitude:storeA.lon];
            CLLocation *locB = [[CLLocation alloc] initWithLatitude:storeB.lat longitude:storeB.lon];
            CLLocationDistance disA = [aLoc distanceFromLocation:locA];
            CLLocationDistance disB = [aLoc distanceFromLocation:locB];
            
            if (disA > disB)
                return NSOrderedDescending;
            else if (disA < disB)
                return NSOrderedAscending;
            else
                return NSOrderedSame;
            
        }];
    }
    else {
        sortedArray = array;
    }
    return sortedArray;
}

- (void) createDatabase {
    NSArray *documentsPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *databaseFilePath=[[documentsPath objectAtIndex:0] stringByAppendingPathComponent:@"Stores"];
    if (sqlite3_open([databaseFilePath UTF8String], &database)==SQLITE_OK) {
        NSLog(@"Database opened");
    }
}

- (void) fetchData {
    //[self createDatabase];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"all-shop" ofType:@"json"];
    NSData *storeData = [NSData dataWithContentsOfFile:filePath];
    if (storeData) {
        NSError *error = nil;
        NSArray *storesRaw = [NSJSONSerialization
                           JSONObjectWithData:storeData
                           options:kNilOptions
                           error:&error];
        if (error != nil) {
            NSLog(@"Parsing json error");
            return;
        }
        else {
            NSLog(@"Parsing success, %d stores", [storesRaw count]);
        }
        
        stores = [[NSMutableArray alloc] init];
        
        for (int i=0; i<[storesRaw count]; i++) {
            NSDictionary *storeRaw = [storesRaw objectAtIndex:i];
            NSString *name = [storeRaw objectForKey:@"NAME"];
            NSString *addr = [storeRaw objectForKey:@"addr"];
            NSNumber *lat = [storeRaw objectForKey:@"py"];
            NSNumber *lon = [storeRaw objectForKey:@"px"];
            Store *store = [[Store alloc] initWithName:name
                                               andAddr:addr
                                                andLat:[lat doubleValue]
                                                andLon:[lon doubleValue]];
            [stores addObject:store];
        }
        NSLog(@"Saved %d stores", [stores count]);
    }
}

@end
