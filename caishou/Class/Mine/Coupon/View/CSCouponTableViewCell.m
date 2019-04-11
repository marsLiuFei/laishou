//
//  CSCouponTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/3.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCouponTableViewCell.h"

@interface CSCouponTableViewCell ()
{
    UIImageView *_bgImageView;
    UILabel *_titleLabel;
    UILabel *_statusLabel;
    UILabel *_standardLabel;
    UILabel *_desLabel;
    UILabel *_timeLabel;
}



@end

@implementation CSCouponTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = WhiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    UIView *contentView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE(15));
        make.right.mas_equalTo(-19);
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(0);
    }];
    
    _bgImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [contentView addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
    _titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"优惠券减10" textColor:RGB(255, 255, 255) textAlignment:Left font:RegularFont(20)];
    [contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(20));
        make.width.offset(SIZE(150));
        make.top.offset(SIZE(20));
        make.height.offset(21);
    }];
    _statusLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"未使用" textColor:RGB(255, 255, 255) textAlignment:Center font:RegularFont(10)];
    _statusLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    _statusLabel.layer.borderWidth = 1;
    _statusLabel.clipsToBounds = true;
    _statusLabel.layer.cornerRadius = 5;
    [contentView addSubview:_statusLabel];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_titleLabel.mas_right).offset(SIZE(10));
        make.width.offset(SIZE(45));
        make.top.mas_equalTo(self ->_titleLabel.mas_top).offset(SIZE(3));
        make.height.offset(17);
    }];
    _standardLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor whiteColor] text:@"购物满99元使用" textColor:RGB(238, 84, 72) textAlignment:Center font:MediumFont(12)];
    [contentView addSubview:_standardLabel];
    [_standardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_titleLabel.mas_left);
        make.width.offset(SIZE(110));
        make.top.mas_equalTo(self ->_titleLabel.mas_bottom).offset(SIZE(3));
        make.height.offset(21);
    }];
    _desLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"全场通用，不可叠加使用，不可与其他优惠券 同时使用" textColor:[UIColor whiteColor] textAlignment:Left font:RegularFont(10)];
    _desLabel.numberOfLines = 2;
    [contentView addSubview:_desLabel];
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_titleLabel.mas_left);
        make.right.mas_equalTo(self ->_statusLabel.mas_right);
        make.top.mas_equalTo(self ->_standardLabel.mas_bottom).offset(SIZE(3));
        make.height.offset(32);
    }];
    _timeLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"有效期：2019-01-20至2019-06-20" textColor:[UIColor whiteColor] textAlignment:Left font:RegularFont(12)];
    [contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_titleLabel.mas_left);
        make.right.mas_equalTo(self ->_statusLabel.mas_right);
        make.bottom.mas_equalTo(-SIZE(5));
        make.height.offset(21);
    }];
    
    
    
}

@end
