//
//  FriendItemViewModel.h
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/27.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "BaseViewModel.h"
#import "Person.h"

@interface FriendItemViewModel : BaseViewModel

// 模型中用到哪些,声明哪些属性

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *headerImg;
@property (nonatomic, copy) NSString *tel;

@end
