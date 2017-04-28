//
//  LoginViewModel.h
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/21.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pwd;

@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, strong) RACSubject *loginResultSignal;

@property (nonatomic, assign, getter=isRequest) BOOL request;

@end
