//
//  Person.h
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/24.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GenderType) {
    GenderTypeMale = 1,
    GenderTypeFemale,
};

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *headerImg;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, assign) GenderType gender;
@property (nonatomic, assign) BOOL isAdmin;
@property (nonatomic, strong) NSArray *friends;

@end
