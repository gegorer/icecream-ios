//
//  Store.m
//  icecream
//
//  Created by Shao Hang Kao on 2013/11/12.
//  Copyright (c) 2013年 gegorer. All rights reserved.
//

#import "Store.h"

@implementation Store

@synthesize name;
@synthesize addr;
@synthesize lat;
@synthesize lon;

- (Store *) initWithName:(NSString *)aName andAddr:(NSString *)aAddr andLat:(double)aLat andLon:(double)aLon {
    if (self = [super init]) {
        self.name = aName;
        self.addr = aAddr;
        self.lat = aLat;
        self.lon = aLon;
    }
    
    return self;
}

@end
