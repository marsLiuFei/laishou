//
//  CSHomeNavView.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/20.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSHomeNavView.h"

@interface CSHomeNavView()
{
    UIButton *leftBtn;
}
@end

@implementation CSHomeNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    return self;
}
- (void)setupUI {
    UIView *topView = [[UIView alloc] init];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mas_top).offset(kStatusBarHeight);
    }];
    leftBtn = [[UIButton alloc] init];
    [leftBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"合肥" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = RegularFont(SIZE(14));
    [leftBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(3.0,SIZE(55) - leftBtn.imageView.frame.origin.x - leftBtn.imageView.frame.size.width,0.0,SIZE(15))];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0,-(SIZE(55) - leftBtn.titleLabel.frame.size.width),0.0, 0.0)];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE(10));
        make.top.mas_equalTo(SIZE(5));
        make.bottom.mas_equalTo(SIZE(-5));
        make.width.mas_equalTo(SIZE(55));
    }];
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(scanClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(12);
        make.bottom.mas_equalTo(-12);
        make.width.mas_equalTo(rightBtn.mas_height);
    }];
    UIView *searchView = [[UIView alloc] init];
    searchView.layer.masksToBounds = true;
    searchView.layer.cornerRadius = (self.viewHeight-kStatusBarHeight - 20) / 2;
    searchView.backgroundColor = [UIColor whiteColor];
    [topView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(self->leftBtn.mas_right).offset(15);
        make.right.mas_equalTo(rightBtn.mas_left).offset(-15);
    }];
    UIImageView *searchImage = [[UIImageView alloc] init];
    searchImage.image = [UIImage imageNamed:@"searchIcon"];
    [searchView addSubview:searchImage];
    [searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-7);
         make.top.mas_equalTo(7);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(searchImage.mas_height);
    }];
    UITextField *searchField = [[UITextField alloc] init];
    searchField.placeholder = @"搜索";
    searchField.font = RegularFont(14);
    [searchField addTarget:self action:@selector(inputChange:) forControlEvents:UIControlEventEditingDidBegin];
    [searchView addSubview:searchField];
    [searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(searchImage.mas_right).offset(5);
        make.right.mas_equalTo(-20);
    }];
    
}

#pragma mark - click
- (void)locationBtnClick:(UIButton *)sender {
    if (self.chooseSiteBtnClickBlock) {
        self.chooseSiteBtnClickBlock(0);
    }
}
- (void)scanClick:(UIButton *)sender {
    if (self.chooseSiteBtnClickBlock) {
        self.chooseSiteBtnClickBlock(1);
    }
}
- (void)inputChange:(UITextField *)field {
    field.text = @"";
    [self endEditing:true];
    if (self.chooseSiteBtnClickBlock) {
        self.chooseSiteBtnClickBlock(2);
    }
}



-(void)setSiteStr:(NSString *)siteStr{
    _siteStr = siteStr;
    [leftBtn setTitle:_siteStr forState:UIControlStateNormal];
}
@end
