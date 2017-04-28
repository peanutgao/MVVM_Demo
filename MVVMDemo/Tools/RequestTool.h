//
//  RequestTool.h
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/21.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestTool : NSObject

+ (instancetype)shareInstance;

- (NSURLSessionDataTask *)requestDataWithURL:(NSString *)urlString
                    params:(NSDictionary *)params
             successHandle:(void (^)(NSObject *data))successHandler
             failureHandle:(void (^)(NSError *error))failureHandle;

@end
