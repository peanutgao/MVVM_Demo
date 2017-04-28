//
//  LoginViewModel.m
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/21.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self bind];
    }
    return self;
}

- (void)bind {
    @weakify(self);
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [[self loginRequest] takeUntil:self.rac_willDeallocSignal];
    }];
    
    self.loginResultSignal = [RACSubject subject];
}

- (RACSignal *)loginRequest {
    self.request = YES;
    
    
    NSDictionary *params = nil;
    @weakify(self);
    return [[[[RequestManager requestDataWithURLString:@"" params:params]
            doNext:^(id  _Nullable x) {
                @strongify(self);
                [self.loginResultSignal sendNext:x];
            }]
            doError:^(NSError * _Nonnull error) {
                @strongify(self);
                [self.loginResultSignal sendError:error];
            }]
            doCompleted:^{
                @strongify(self);
                self.request = NO;
            }];
}

@end
