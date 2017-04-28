//
//  FriendItemViewModel.m
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/27.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "FriendItemViewModel.h"

@implementation FriendItemViewModel

+ (instancetype)viewModelWithObj:(id)obj {
    FriendItemViewModel *vm = [[FriendItemViewModel alloc] init];
    if ([obj isKindOfClass:[Person class]]) {
        [vm initializeWithModel:obj];
    }
    return vm;
}

- (void)initializeWithModel:(Person *)p {
    RAC(self, name) = RACObserve(p, name);
    RAC(self, tel) = RACObserve(p, tel);
    RAC(self, headerImg) = RACObserve(p, headerImg);
}

@end
