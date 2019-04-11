//
//  CSWeightRecordTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSWeightRecordTableViewCell.h"

@interface CSWeightRecordTableViewCell ()
{
    UIImageView *_rightImageView;
    UILabel *_weightlabel;
    UILabel *_hintLabel;
}

@end


@implementation CSWeightRecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}
#pragma mark - setupUI;
- (void)setupUI {
    UIView *lineView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(67, 207, 124)];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.top.offset(SIZE(15));
        make.width.offset(SIZE(2));
        make.height.offset(SIZE(15));
    }];
    UILabel *recordLabel  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"体重记录" textColor:RGB(53, 60, 54) textAlignment:NSTextAlignmentLeft font:MediumFont(16)];
    [self.contentView addSubview:recordLabel];
    [recordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_top).offset(SIZE(-4));
        make.left.mas_equalTo(lineView.mas_right).offset(5);
        make.height.offset(SIZE(21));
        make.right.offset(0);
    }];
    _weightlabel  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"100.0kg" textColor:RGB(237, 130, 32) textAlignment:NSTextAlignmentLeft font:MediumFont(20)];
    [self.contentView addSubview:_weightlabel];
    [_weightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(recordLabel.mas_bottom);
        make.left.mas_equalTo(recordLabel.mas_left);
        make.width.offset(SCREEN_WIDTH *0.33);
        make.bottom.offset(SIZE(-10));
    }];
    _hintLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"近一周体重走势图，这一周您瘦了3kg" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentRight font:RegularFont(10)];
    [self.contentView addSubview:_hintLabel];
    [_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SIZE(21));
        make.right.offset(SIZE(-15));
        make.left.mas_equalTo(self ->_weightlabel.mas_right);
        make.bottom.offset(SIZE(-10));
    }];
    _rightImageView =  [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"trend"];
    [self.contentView addSubview:_rightImageView];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self ->_hintLabel.mas_top);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(self ->_hintLabel.mas_right);
        make.width.mas_equalTo(167);
    }];
    
    
}

- (void)setMyInfo:(CSMyInfoModel *)myInfo {
    _myInfo = myInfo;
    _weightlabel.text = isEmptyStr(myInfo.weight)?@"":[NSString stringWithFormat:@"%@kg",myInfo.weight];
    _hintLabel.text = isEmptyStr(myInfo.thenLose)?@"近一周体重走势图，这一周您瘦了0kg":[NSString stringWithFormat:@"近一周体重走势图，这一周您瘦了%@kg",myInfo.thenLose];
}

@end
