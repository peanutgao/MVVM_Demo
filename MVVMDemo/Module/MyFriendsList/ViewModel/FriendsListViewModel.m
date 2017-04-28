//
//  FriendsListViewModel.m
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/24.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "FriendsListViewModel.h"
#import "Person.h"
#import "FriendItemViewModel.h"

@interface FriendsListViewModel ()

@end

@implementation FriendsListViewModel


- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    @weakify(self);
    self.requstDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [[self requestSignal] takeUntil:self.rac_willDeallocSignal];
    }];
}

- (RACSignal *)requestSignal {
    @weakify(self);
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends.json" ofType:nil];
        
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path]
                                                 options:NSJSONReadingMutableLeaves
                                                   error:&error];
        
        Person *p = [Person yy_modelWithDictionary:obj];
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:p.friends.count];
        
        for (Person *x in p.friends) {
            FriendItemViewModel *vm = [FriendItemViewModel viewModelWithObj:x];
            [arrayM addObject:vm];
        }
        
        
        self.friendsList = arrayM.copy;
        self.name = p.name;
        self.headerImg = p.headerImg;
        self.tel = p.tel;
        
        
        [subscriber sendNext:p];
        [subscriber sendError:error];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    return signal;
}

@end
