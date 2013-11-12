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
    [self fetchData];
}

- (NSArray *) fetchWithKeyword:(NSString *)aKeyword {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i=0; i<[stores count]; i++) {
        Store *store = [stores objectAtIndex:i];
        if (aKeyword != nil) {
            NSRange range = [[store name] rangeOfString:aKeyword];
            if (range.location == NSNotFound) {
                continue;
            }
        }
        [array addObject: store];
    }
    return array;
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
            Store *store = [[Store alloc] initWithName:[storeRaw objectForKey:@"NAME"] andAddr:[storeRaw objectForKey:@"addr"]];
            [stores addObject:store];
        }
        NSLog(@"Saved %d stores", [stores count]);
    }
}

@end
