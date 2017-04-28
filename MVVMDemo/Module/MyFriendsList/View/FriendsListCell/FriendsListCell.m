//
//  FriendsListCell.m
//  MVVMDemo
//
//  Created by Joseph Gao on 2017/4/24.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "FriendsListCell.h"

@interface FriendsListCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *telLabel;

@property (nonatomic, strong) FriendItemViewModel *viewModel;

@end

@implementation FriendsListCell

- (void)bindWithViewModel:(BaseViewModel *)vm {
    if ([vm isKindOfClass:[FriendItemViewModel class]]) {
        self.viewModel = (FriendItemViewModel *)vm;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupSubviews];
        [self bind];
    }
    
    return self;
}

- (void)setupSubviews {
    CGFloat x = 15.0;
    CGFloat y = 5.0;
    CGFloat wh = 65.0 - y * 2;
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, wh, wh)];
    _iconView.layer.cornerRadius = wh * 0.5;
    _iconView.layer.borderColor = [UIColor grayColor].CGColor;
    _iconView.layer.borderWidth = 1.0;
    _iconView.clipsToBounds = YES;
    [self.contentView addSubview:_iconView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconView.frame) + 5, y + 5, 200.0, 20.0)];
    [self.contentView addSubview:_nameLabel];
    
    _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x,
                                                          CGRectGetMaxY(_nameLabel.frame) + 5,
                                                          _nameLabel.frame.size.width,
                                                          _nameLabel.frame.size.height)];
    [self.contentView addSubview:_telLabel];
}


- (void)bind {
    self.viewModel = [[FriendItemViewModel alloc] init];
    
    @weakify(self);
    [[RACObserve(self, viewModel)
      distinctUntilChanged]
     subscribeNext:^(FriendItemViewModel * _Nullable x) {
         @strongify(self);
         self.nameLabel.text = x.name;
         self.telLabel.text = x.tel;
         [self.iconView sd_setImageWithURL:[NSURL URLWithString:x.headerImg]
                          placeholderImage:[UIImage imageNamed:@"place_holder"]];
     }];
}
@end
