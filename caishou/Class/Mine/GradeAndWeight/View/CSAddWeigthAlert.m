//
//  CSAddWeigthAlert.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/20.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSAddWeigthAlert.h"

@interface CSAddWeigthAlert ()<UITextFieldDelegate>
{
    UITextField *_field;
}
@end

@implementation CSAddWeigthAlert
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(0, 0,0)];
    bgView.alpha = 0.6;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.offset(0);
    }];
    UIView *centerView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor];
    [self addSubview:centerView];
    centerView.clipsToBounds= true;
    centerView.layer.cornerRadius = 5;
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SIZE(271));
        make.width.mas_equalTo(SIZE(256));
        make.centerX.offset(0);
        make.centerY.offset(0);
    }];
    
    UITextField *field = [ViewCreate createTextFieldFrame:CGRectMake(0, 0, 0, 0) font:MediumFont(16) textColor:BlackColor placeHolder:@"" delegate:self];
    field.textAlignment = Center;
    field.layer.borderWidth = 1;
    field.layer.borderColor = RGB(203, 203, 203).CGColor;
    field.clipsToBounds = true;
    field.layer.cornerRadius = 5;
    field.keyboardType =  UIKeyboardTypeNumberPad;
    [centerView addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.offset(0);
        make.height.offset(SIZE(40));
        make.width.offset(SIZE(150));
    }];
    _field = field;
    UILabel *hintLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"请输入您目前的体重" textColor:RGB(70, 210, 127) textAlignment:Center font:MediumFont(16)];
    [centerView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.mas_equalTo(field.mas_top).offset(SIZE(-25));
        make.height.offset(SIZE(21));
    }];
    UILabel *kgLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"KG" textColor:RGB(70, 210, 127) textAlignment:Center font:RegularFont(12)];
    [centerView addSubview:kgLabel];
    [kgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(field.mas_bottom).offset(SIZE(5));
        make.height.offset(SIZE(21));
    }];
    UIButton *cancleBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"取消" titleColor:RGB(70, 210, 127) font:MediumFont(16) backgroundColor:WhiteColor touchUpInsideEvent:nil];
    cancleBtn.clipsToBounds = true;
    cancleBtn.layer.cornerRadius = 5;
    cancleBtn.layer.borderColor = RGB(70, 210, 127).CGColor;
    cancleBtn.layer.borderWidth = 1;
    [cancleBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE(17));
        make.bottom.mas_equalTo(SIZE(-12));
        make.width.offset(SIZE(100));
        make.height.offset(SIZE(30));
    }];
    UIButton *sureBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"保存" titleColor:WhiteColor font:MediumFont(16) backgroundColor:RGB(70, 210, 127) touchUpInsideEvent:nil];
    sureBtn.clipsToBounds = true;
    sureBtn.layer.cornerRadius = 5;
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(cancleBtn.mas_width);
        make.height.mas_equalTo(cancleBtn.mas_height);
        make.right.mas_equalTo(SIZE(-17));
        make.bottom.mas_equalTo(cancleBtn.mas_bottom);
    }];
    
    
    
   
}
- (void)cancleBtnClick:(UIButton *)sender {
    [self removeFromSuperview];
}
- (void)sureBtnClick:(UIButton *)sender {
    [self removeFromSuperview];
    if (self.addWeightBtnBlock) {
        self.addWeightBtnBlock(_field.text);
    }
}

@end
