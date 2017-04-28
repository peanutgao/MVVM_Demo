//
//  RequestManager.h
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/21.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject

+ (RACSignal *)requestDataWithURLString:(NSString *)urlString params:(NSDictionary *)params;

@end
