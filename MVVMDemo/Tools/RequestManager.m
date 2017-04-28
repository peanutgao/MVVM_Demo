//
//  RequestManager.m
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/21.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "RequestManager.h"
#import "RequestTool.h"

@implementation RequestManager

+ (RACSignal *)requestDataWithURLString:(NSString *)urlString params:(NSDictionary *)params {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSURLSessionDataTask *task = [[RequestTool shareInstance] requestDataWithURL:urlString
                                                                                  params:params
                                                                           successHandle:^(NSObject *data) {
                                                                               [subscriber sendNext:data];
                                                                               [subscriber sendCompleted];
                                                                           }
                                                                           failureHandle:^(NSError *error) {
                                                                               [subscriber sendError:error];
                                                                               [subscriber sendCompleted];
                                                                           }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end
