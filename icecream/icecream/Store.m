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

- (Store *) initWithName:(NSString *)aName andAddr:(NSString *)aAddr {
    if (self = [super init]) {
        self.name = aName;
        self.addr = aAddr;
    }
    
    return self;
}

@end
