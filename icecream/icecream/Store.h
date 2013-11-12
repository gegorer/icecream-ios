//
//  Store.h
//  icecream
//
//  Created by Shao Hang Kao on 2013/11/12.
//  Copyright (c) 2013年 gegorer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject {
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *addr;

- (Store *) initWithName:(NSString *)aName andAddr:(NSString *)aAddr;

@end
