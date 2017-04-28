//
//  Person.m
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/24.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"friends": [Person class],
             };
}

@end
