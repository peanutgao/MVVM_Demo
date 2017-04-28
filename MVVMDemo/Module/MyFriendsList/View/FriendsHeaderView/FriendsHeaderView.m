//
//  FriendsHeaderView.m
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/24.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "FriendsHeaderView.h"
#import <ReactiveObjC/RACDelegateProxy.h>
#import "FriendsListViewModel.h"

@interface FriendsHeaderView () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *sureBtn;

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *telLabel;

@property (nonatomic, strong) FriendsListViewModel *viewModel;

@end

@implementation FriendsHeaderView

- (void)bindWithViewModel:(BaseViewModel *)vm {
    if ([vm isKindOfClass:[FriendsListViewModel class]]) {
        self.viewModel = (FriendsListViewModel *)vm;
    }    
}

-  (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubvews];
        [self bind];
    }
    return self;
}

- (void)setupSubvews {
    CGFloat x = 15.0;
    CGFloat y = 15.0;
    CGFloat h = 30.0;
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(x, y, self.frame.size.width - 130, h)];
    _searchBar.delegate = self;
    [self addSubview:_searchBar];
    
    _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 80 - x, y, 80, h)];
    _sureBtn.layer.borderWidth = 1.0;
    _sureBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [_sureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [_sureBtn setTitle:@"Sure" forState:UIControlStateNormal];
    _sureBtn.enabled = NO;
    [self addSubview:_sureBtn];
    

    CGFloat wh = 55.0;
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_searchBar.frame) + 15, wh, wh)];
    _iconView.layer.cornerRadius = wh * 0.5;
    _iconView.layer.borderColor = [UIColor grayColor].CGColor;
    _iconView.layer.borderWidth = 1.0;
    _iconView.clipsToBounds = YES;
    [self addSubview:_iconView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconView.frame) + 5,
                                                           _iconView.frame.origin.y + 5,
                                                           200.0,
                                                           20.0)];
    [self addSubview:_nameLabel];
    
    _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x,
                                                          CGRectGetMaxY(_nameLabel.frame) + 5,
                                                          _nameLabel.frame.size.width,
                                                          _nameLabel.frame.size.height)];
    [self addSubview:_telLabel];
    
}

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    NSLog(@"---%@", searchText);
//}

- (void)bind {
    RAC(self.nameLabel, text) = [RACObserve(self, viewModel.name) distinctUntilChanged];
    RAC(self.telLabel, text) = [RACObserve(self, viewModel.tel) distinctUntilChanged];

    @weakify(self);
    [[RACObserve(self, viewModel.headerImg)
      distinctUntilChanged]
     subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:x]
                         placeholderImage:[UIImage imageNamed:@"place_holder"]];
    }];

    [[[self rac_signalForSelector:@selector(searchBar:textDidChange:) fromProtocol:@protocol(UISearchBarDelegate)]
      map:^id _Nullable(RACTuple * _Nullable value) {
          //RACTupleUnpack(UISearchBar *searchBar, NSString *searchText) = value;
          
          NSString *searchText = value.second;
          NSLog(@"searchText: %@", searchText);
          return searchText;
    }]
     subscribeNext:^(NSString * _Nullable x) {
         @strongify(self);
         self.sureBtn.enabled = x.length > 3 ? YES : NO;;
    }];

}
@end
