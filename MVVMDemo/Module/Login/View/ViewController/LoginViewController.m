//
//  LoginViewController.m
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/21.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "FriendsListViewController.h"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property (nonatomic, strong) LoginViewModel *viewModel;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Login";
    [self bind];
}

- (void)bind {
    self.viewModel = [[LoginViewModel alloc] init];
    
    @weakify(self);
    [[RACSubject
     combineLatest:@[self.nameFiled.rac_textSignal, self.pwdField.rac_textSignal]
     reduce:^id _Nullable (NSString *name, NSString *pwd){
         return @(name.length > 2 && pwd.length > 2);
     }]
     subscribeNext:^(id  _Nullable x) {
         @strongify(self);
         self.loginBtn.enabled = [x boolValue];
     }];
    
    
    [RACObserve(self.loginBtn, enabled) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.loginBtn.backgroundColor = [x boolValue] ? [UIColor blueColor] : [UIColor lightGrayColor];
    }];
    
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.viewModel.loginCommand execute:@1];
    }];
    
    
    [[self.viewModel.loginResultSignal
      doError:^(NSError * _Nonnull error) {
          NSLog(@"error: %@", error);
    }]
     subscribeNext:^(id  _Nullable x) {
         @strongify(self);
         [self.navigationController pushViewController:[[FriendsListViewController alloc] init] animated:YES];
     }];
    
    
    RAC(self.indicator, animating) = RACObserve(self.viewModel, request);
}

@end
