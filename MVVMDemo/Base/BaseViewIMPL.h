//
//  BaseView.h
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/27.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "BaseViewModel.h"

@protocol BaseViewIMPL <NSObject>

- (void)bindWithViewModel:(BaseViewModel *)vm;

@end
