//
//  RequestTool.m
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/21.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "RequestTool.h"

@implementation RequestTool

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static RequestTool *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSURLSessionDataTask *)requestDataWithURL:(NSString *)urlString
                    params:(NSDictionary *)params
             successHandle:(void (^)(NSObject *data))successHandler
             failureHandle:(void (^)(NSError *error))failureHandler {
    __block NSURLSessionDataTask *task = nil;
    // 模拟请求延迟
    [[RACScheduler mainThreadScheduler] afterDelay:.3 schedule:^{
        if (successHandler) {
            successHandler(@"1");
        }
    }];
        
        
//        NSError *error = [NSError errorWithDomain:@"MyError" code:2048 userInfo:@{NSLocalizedDescriptionKey : @"error_message"}];
//        if (failureHandler) {
//            failureHandler(error);
//        }

        
        
//        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//        task = [mgr GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            
//            if (successHandler) {
//                successHandler(responseObject);
//            }
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            if (failureHandler) {
//                failureHandler(error);
//            }
//        }];
    
    
  
    return task;
}


@end
