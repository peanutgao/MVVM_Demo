//
//  FriendsListViewModel.h
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/24.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "Person.h"

@interface FriendsListViewModel : BaseViewModel

@property (nonatomic, strong) NSArray *friendsList;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *headerImg;

@property (nonatomic, strong) RACCommand *requstDataCommand;

@end
