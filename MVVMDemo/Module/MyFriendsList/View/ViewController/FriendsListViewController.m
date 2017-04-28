//
//  FriendsListViewController.m
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/21.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "FriendsListViewController.h"
#import "FriendsHeaderView.h"
#import "FriendsListCell.h"
#import "FriendsListViewModel.h"
#import "Person.h"

static NSString *const kReuseID = @"kReuseID";


@interface FriendsListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FriendsHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FriendsListViewModel *viewModel;

@end

@implementation FriendsListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubviews];
    [self bind];
}


#pragma mark - Bind

- (void)bind {
    self.viewModel = [[FriendsListViewModel alloc] init];
    // headerView绑定 self.viewModel
    [self.headerView bindWithViewModel:self.viewModel];

    // 信号先订阅
    @weakify(self);
    [[self.viewModel.requstDataCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    [self.viewModel.requstDataCommand execute:@1];
    
}


#pragma mark - TableView Datasource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.friendsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsListCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseID];
    if (!cell) {
        cell = [[FriendsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReuseID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell bindWithViewModel:self.viewModel.friendsList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
}


#pragma mark - Setup UI

- (void)setupSubviews {
    CGFloat headerH = 200.0;
    _headerView = [[FriendsHeaderView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, headerH)];
    _headerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_headerView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                               headerH,
                                                               self.view.bounds.size.width,
                                                               self.view.bounds.size.height - headerH)
                                              style:UITableViewStylePlain];
    _tableView.rowHeight = 65.0;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

@end
