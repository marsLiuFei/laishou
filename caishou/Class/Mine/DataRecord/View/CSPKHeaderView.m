//
//  CSPKHeaderView.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSPKHeaderView.h"

@interface CSPKHeaderView ()
{
    UIImageView *_bgImageView;
    UILabel *_hintLabel;
    UILabel *_weightLabel;
    UILabel *_bmiLabel;
    UILabel *_bodyFatLabel;
}

@end

@implementation CSPKHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    _bgImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"payment_bg"];
    [self addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    _hintLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"健康评级" textColor:WhiteColor textAlignment:NSTextAlignmentLeft font:MediumFont(16)];
    [self addSubview:_hintLabel];
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.top.offset(SIZE(76));
        make.right.offset(SIZE(-15));
        make.height.offset(SIZE(21));
    }];
    [self createTagLabel];
    
    UILabel *weightTitle = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"体重" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:RegularFont(14)];
    [self addSubview:weightTitle];
    [weightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(SIZE(-54));
        make.left.offset(0);
        make.height.offset(SIZE(21));
        make.width.offset(SCREEN_WIDTH *0.33);
    }];
    _weightLabel =  [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"100.0kg" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:RegularFont(14)];
    [self addSubview:_weightLabel];
    [_weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(SIZE(-30));
        make.left.offset(0);
        make.height.offset(SIZE(21));
        make.width.offset(SCREEN_WIDTH *0.33);
    }];
    UILabel *bmiTitle = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"BMI" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:RegularFont(14)];
    [self addSubview:bmiTitle];
    [bmiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weightTitle.mas_bottom);
        make.left.mas_equalTo(weightTitle.mas_right).offset(0);
        make.height.offset(SIZE(21));
        make.width.offset(SCREEN_WIDTH *0.33);
    }];
    _bmiLabel =  [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"37.5" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:RegularFont(14)];
    [self addSubview:_bmiLabel];
    [_bmiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self ->_weightLabel.mas_bottom);
        make.left.mas_equalTo(weightTitle.mas_right).offset(0);
        make.height.offset(SIZE(21));
        make.width.offset(SCREEN_WIDTH *0.33);
    }];
    UILabel *bodyFatTitle = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"体脂率" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:RegularFont(14)];
    [self addSubview:bodyFatTitle];
    [bodyFatTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weightTitle.mas_bottom);
        make.right.offset(0);
        make.height.offset(SIZE(21));
        make.width.offset(SCREEN_WIDTH *0.33);
    }];
    _bodyFatLabel =  [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"65.2%" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:RegularFont(14)];
    [self addSubview:_bodyFatLabel];
    [_bodyFatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.mas_equalTo(self ->_weightLabel.mas_bottom);
        make.right.offset(0);
        make.height.offset(SIZE(21));
        make.width.offset(SCREEN_WIDTH *0.33);
    }];
    
}
- (void)createTagLabel {
   __block CGFloat width = 15;
    for (int i = 0; i < 5; i ++) {
        UILabel *label = [[UILabel alloc] init];
        label.font = MediumFont(16);
        label.textColor = WhiteColor;
        label.textAlignment = NSTextAlignmentCenter;
        switch (i) {
            case 0:{
                label.text = @"S";
                label.backgroundColor = RGB(110, 203, 132);
            }
            break;
            case 1:{
                label.text = @"A";
                label.backgroundColor = RGB(157, 204, 89);
            }
            break;
            case 2:{
                label.text = @"B";
                label.backgroundColor = RGB(208, 203, 92);
            }
            break;
            case 3:{
                label.text = @"C";
                label.backgroundColor = RGB(249, 210, 71);
                label.transform = CGAffineTransformMakeScale(1.2, 1.2);
            }
            break;
            case 4:{
                label.text = @"F";
                label.backgroundColor = RGB(215, 111, 77);
            }
            break;
            default:
                break;
        }
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(SIZE(width) + i * SIZE(26));
            make.top.mas_equalTo(self -> _hintLabel.mas_bottom).offset(10);
            make.width.height.offset(SIZE(26));
            width = width +5;
        }];
       
    }
}

- (void)setMyInfo:(CSMyInfoModel *)myInfo {
    _myInfo = myInfo;
    _weightLabel.text = isEmptyStr(myInfo.weight)?@"":myInfo.weight;
    _bmiLabel.text = isEmptyStr(myInfo.bmi)?@"":myInfo.bmi;
    _bodyFatLabel.text = isEmptyStr(myInfo.fatRate)?@"0%%":[NSString stringWithFormat:@"%.2lf%%",[myInfo.fatRate floatValue]];
}

@end
