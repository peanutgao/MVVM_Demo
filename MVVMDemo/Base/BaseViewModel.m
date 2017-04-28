//
//  BaseViewModel.m
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/27.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

+ (instancetype)viewModelWithObj:(id)obj {
    BaseViewModel *vm = [[BaseViewModel alloc] init];
    return vm;
}

@end
