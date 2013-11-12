//
//  Stores.h
//  icecream
//
//  Created by Shao Hang Kao on 2013/11/12.
//  Copyright (c) 2013年 gegorer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stores : NSObject

+ (Stores *) singleton;
- (void) checkData;
- (NSArray *) fetchWithKeyword:(NSString *)aKeyword;

@end
