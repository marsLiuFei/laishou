//
//  CSGradeHeaderView.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/19.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSGradeHeaderView.h"
#import "ZYQWaterWaveView.h"

@interface CSGradeHeaderView ()
{
    UILabel *_weightLabel;
    UILabel *_hintLabel;
    UIButton *_recordBtn;
    ZYQWaterWaveView *_waveView;
    UILabel *_titleLabel;
}

@end

@implementation CSGradeHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
- (void)createUI {
    UIView *topView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(70, 210, 127)];
    UIView *centerView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(70, 210, 127)];
    [topView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavBarHeight);
        make.bottom.offset(0);
        make.height.mas_equalTo(centerView.mas_width);
        make.centerX.offset(0);
    }];
    _hintLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"请您继续保持哦！" textColor:WhiteColor textAlignment:Center font:RegularFont(14)];
    [centerView addSubview:_hintLabel];
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(SIZE(-10));
        make.height.offset(SIZE(15));
    }];
    UIView *circleView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(70, 210, 127)];
//    circleView.layer.borderWidth = 2;
//    circleView.layer.borderColor = RGB(149, 221, 170).CGColor;
//    circleView.layer.masksToBounds = true;
//    circleView.layer.cornerRadius = SIZE(105/2);
    [centerView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(SIZE(105));
        make.bottom.mas_equalTo(self ->_hintLabel.mas_top).offset(SIZE(-10));
        make.centerX.offset(0);
    }];
    
    ZYQWaterWaveView *waveView = [[ZYQWaterWaveView alloc] initWithFrame:CGRectMake(0, 0, SIZE(105), SIZE(105))];
    waveView.backgroundColor = [UIColor clearColor];
    waveView.clipsToBounds = true;
    waveView.layer.cornerRadius = SIZE(105)*0.5;
    waveView.layer.borderColor = RGB(149, 220, 170).CGColor;
    waveView.layer.borderWidth = 1;
    [circleView addSubview:waveView];
    [waveView updateViewGradientFromColor:RGB(149, 220, 170) toColor:RGB(220, 235, 240) withRange:waveView.frame.size.width];
    [waveView showDripAnmin:@(0.6)];
    _waveView = waveView;
    UILabel *titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"比上次瘦" textColor:WhiteColor textAlignment:Center font:MediumFont(12)];
    [circleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(SIZE(21));
        make.height.offset(SIZE(21));
    }];
    _titleLabel = titleLabel;
    _weightLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"10" textColor:WhiteColor textAlignment:Center font:MediumFont(26)];
    [circleView addSubview:_weightLabel];
    [_weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(SIZE(10));
        make.height.offset(SIZE(21));
        make.centerX.offset(SIZE(-15));
    }];
    UILabel *unitLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"公斤" textColor:WhiteColor textAlignment:Center font:RegularFont(10)];
    [circleView addSubview:unitLabel];
    [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self ->_weightLabel.mas_bottom);
        make.height.offset(SIZE(15));
        make.left.mas_equalTo(self ->_weightLabel.mas_right).offset(SIZE(5));
    }];
    
    
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(self.frame.size.height* 0.7);
    }];
    UIView *bottomView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(238, 238, 238)];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.offset(self.frame.size.height* 0.3);
    }];
    _recordBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"记录今天的体重" titleColor:WhiteColor font:MediumFont(16) backgroundColor:RGB(70, 210, 127) touchUpInsideEvent:nil];
    _recordBtn.clipsToBounds = true;
    _recordBtn.layer.cornerRadius = 5;
    [_recordBtn addTarget:self action:@selector(addWeigth:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_recordBtn];
    [_recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(SIZE(251));
        make.height.offset(SIZE(45));
        make.centerX.centerY.offset(0);
    }];
    
}
- (void)addWeigth:(UIButton *)sender {
    if (self.addWeightBlock) {
        self.addWeightBlock();
    }
}
- (void)setupWeigth:(NSInteger)weight {
    _titleLabel.text = @"比上次瘦";
    _hintLabel.text = @"请您继续保持哦！";
    _hintLabel.textColor = WhiteColor;
    _weightLabel.text = [NSString stringWithFormat:@"%ld" , weight];
    if (weight >= 0) {
        [_waveView updateViewGradientFromColor:RGB(149, 220, 170) toColor:RGB(220, 235, 240) withRange:_waveView.frame.size.width];
        CGFloat ratio = (weight + 50) / 100.0;
        [_waveView showDripAnmin:@(ratio)];
        return;
    }
    
     weight = 0 -weight;
     _weightLabel.text = [NSString stringWithFormat:@"%ld" , weight];
    _titleLabel.text = @"比上次胖";
    _hintLabel.text = @"请您继续加油呀！";
    _hintLabel.textColor = RGB(237, 143, 137);
    [_waveView updateViewGradientFromColor:RGB(237, 143, 137) toColor:RGB(187, 88, 73) withRange:_waveView.frame.size.width];
    CGFloat ratio = weight / 100.0;
    if (ratio > 0.5) {
         ratio = 0.5;
    }
    ratio = ratio - 0.5;
    if (ratio < 0.02) {
        ratio = 0.02;
    }
    [_waveView showDripAnmin:@(0.5 -ratio)];
    return;
}

@end
