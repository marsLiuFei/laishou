//
//  CSExampleTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSExampleTableViewCell.h"

@interface CSExampleTableViewCell ()
{
    UILabel *_numberLabel;
    UILabel *_personLabel;
    UILabel *_subLabel;
    UIButton *_chooseBtn;
}


@end

@implementation CSExampleTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self createrUI];
    }
    return self;
}
- (void)createrUI {
    _numberLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"0" textColor:RGB(53, 60, 54) textAlignment:NSTextAlignmentLeft font: [UIFont fontWithName:@"PingFangSC-Semibold" size: 20]];
    [self addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        CGFloat width = [ZYQTool ZYQ_returnWidthAccordingText:self ->_numberLabel.text font:[UIFont fontWithName:@"PingFangSC-Semibold" size:20] height:21];
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(11);
        make.height.mas_equalTo(21);
//        make.width.mas_equalTo(width);
        
    }];
    
    _personLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"人" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Semibold" size: 14]];
    [self addSubview:_personLabel];
    [_personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_numberLabel.mas_right).offset(6);
        make.top.mas_equalTo(self -> _numberLabel.mas_top);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(self -> _numberLabel.mas_height);
    }];
    _subLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"已在莱瘦平台减肥成功" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Semibold" size: 14]];
    [self addSubview:_subLabel];
    [_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_numberLabel.mas_left);
        make.top.mas_equalTo(self -> _numberLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(21);
        make.width.mas_lessThanOrEqualTo(self.mas_width).multipliedBy(0.6);
    }];
   
    _chooseBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"帮我选顾问" titleColor:[UIColor whiteColor] font:[UIFont fontWithName:@"PingFangSC-Semibold" size: 14] backgroundColor:RGB(67, 207, 124) touchUpInsideEvent:nil];
    [_chooseBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_chooseBtn];
    [_chooseBtn setImage:[UIImage imageNamed:@"touchBtn"] forState:UIControlStateNormal];
    [_chooseBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE(18));
        make.right.mas_equalTo(SIZE(-15));
        make.bottom.mas_equalTo(SIZE(-18));
        make.width.mas_equalTo(SIZE(160));
    }];
    
}
- (void) btnClick{
    if (self.moreBtnClickBlock) {
        self.moreBtnClickBlock();
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _chooseBtn.clipsToBounds = true;
    _chooseBtn.layer.cornerRadius = (self.viewHeight - SIZE(18)*2)*0.5;
}

-(void)setUserNumber:(NSString *)userNumber{
    _userNumber = userNumber;
    _numberLabel.text = isEmptyStr(_userNumber)?@"0":_userNumber;
    
    NSString *loginType = [UDefault getObject:LoginType];
    if ([loginType isEqualToString:@"5"]) {
        //顾问
        _chooseBtn.hidden = YES;
    }
}

@end
