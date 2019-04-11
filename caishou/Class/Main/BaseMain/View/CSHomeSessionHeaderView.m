//
//  CSHomeSessionHeaderView.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/21.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSHomeSessionHeaderView.h"
@interface CSHomeSessionHeaderView()
{
    UILabel *_titleLabel;
    UIButton *_rightBtn;
}

@end

@implementation CSHomeSessionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
#pragma mark - setupUI
- (void)setupUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = RGB(53, 60, 54);
    _titleLabel.font = MediumFont(SIZE(18));
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.width.mas_offset(120);
    }];
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.titleLabel.font = RegularFont(SIZE(12));
    [_rightBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    [self addSubview:_rightBtn];
    [_rightBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.right.mas_equalTo(-16);
        make.width.mas_equalTo(40);
    }];
    
}

#pragma mark - click
- (void)moreBtnClick:(UIButton *)sender {
    NSLog(@"点击了更多按钮");
    if (self.moreBtnClickBlock) {
        self.moreBtnClickBlock();
    }
}

- (void)setHeaderModel:(CSHomeSessionHeaderModel *)headerModel {
    _headerModel = headerModel;
    _titleLabel.text = headerModel.title;
    [_rightBtn setTitle:headerModel.rightTitle forState:UIControlStateNormal];
    [_rightBtn setImage:[UIImage imageNamed:headerModel.iconStr] forState:UIControlStateNormal];
}

@end
