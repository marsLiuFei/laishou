//
//  CSBeleaguerRecordCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/12.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBeleaguerRecordCell.h"

@interface CSBeleaguerRecordCell ()
{
    UILabel *_chestlabel;
    UILabel *_waistlineLabel;
    UILabel *_hiplineLabel;
    UILabel *_standardChest;
    UILabel *_standardWaistline;
    UILabel *_standardHipline;
}

@end

@implementation CSBeleaguerRecordCell

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
    UILabel *recordLabel  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"围度记录" textColor:RGB(53, 60, 54) textAlignment:NSTextAlignmentLeft font:MediumFont(16)];
    [self.contentView addSubview:recordLabel];
    [recordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_top).offset(SIZE(-4));
        make.left.mas_equalTo(lineView.mas_right).offset(5);
        make.height.offset(SIZE(21));
        make.right.offset(0);
    }];
    
    UILabel *standardChest  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"标准胸围：79.0" textColor:RGB(237, 130, 32) textAlignment:NSTextAlignmentCenter font:RegularFont(10)];
    [self.contentView addSubview:standardChest];
    [standardChest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.left.mas_equalTo(0);
        make.width.offset(SCREEN_WIDTH *0.33);
        make.bottom.offset(SIZE(-10));
    }];
    _standardChest= standardChest;
    UILabel *chestHint  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"我的胸围" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentCenter font:RegularFont(12)];
    [self.contentView addSubview:chestHint];
    [chestHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(standardChest.mas_height);
        make.left.mas_equalTo(standardChest.mas_left);
        make.width.mas_equalTo(standardChest.mas_width);
        make.bottom.mas_equalTo(standardChest.mas_top);
    }];
    _chestlabel  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"91.3cm" textColor:RGB(67, 207, 124) textAlignment:NSTextAlignmentCenter font:MediumFont(20)];
    [self.contentView addSubview:_chestlabel];
    [_chestlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(chestHint.mas_height);
        make.left.mas_equalTo(chestHint.mas_left);
        make.width.mas_equalTo(chestHint.mas_width);
        make.bottom.mas_equalTo(chestHint.mas_top);
    }];
    
    UILabel *standardWaistline  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"标准腰围：54.4" textColor:RGB(237, 130, 32) textAlignment:NSTextAlignmentCenter font:RegularFont(10)];
    [self.contentView addSubview:standardWaistline];
    [standardWaistline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.left.mas_equalTo(self ->_chestlabel.mas_right);
        make.width.offset(SCREEN_WIDTH *0.33);
        make.bottom.offset(SIZE(-10));
    }];
    _standardWaistline = standardWaistline;
    UILabel *waistlineHint  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"我的腰围" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentCenter font:RegularFont(12)];
    [self.contentView addSubview:waistlineHint];
    [waistlineHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(standardWaistline.mas_height);
        make.left.mas_equalTo(standardWaistline.mas_left);
        make.width.mas_equalTo(standardWaistline.mas_width);
        make.bottom.mas_equalTo(standardWaistline.mas_top);
    }];
    _waistlineLabel  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"78.3cm" textColor:RGB(67, 207, 124) textAlignment:NSTextAlignmentCenter font:MediumFont(20)];
    [self.contentView addSubview:_waistlineLabel];
    [_waistlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(waistlineHint.mas_height);
        make.left.mas_equalTo(waistlineHint.mas_left);
        make.width.mas_equalTo(waistlineHint.mas_width);
        make.bottom.mas_equalTo(waistlineHint.mas_top);
    }];

    UILabel *standardHipline  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"标准臀围：86.7" textColor:RGB(237, 130, 32) textAlignment:NSTextAlignmentCenter font:RegularFont(10)];
    [self.contentView addSubview:standardHipline];
    [standardHipline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.left.mas_equalTo(self ->_waistlineLabel.mas_right);
        make.width.offset(SCREEN_WIDTH *0.33);
        make.bottom.offset(SIZE(-10));
    }];
    _standardHipline = standardHipline;
    UILabel *hiplineHint  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"我的臀围" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentCenter font:RegularFont(12)];
    [self.contentView addSubview:hiplineHint];
    [hiplineHint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(standardHipline.mas_height);
        make.left.mas_equalTo(standardHipline.mas_left);
        make.width.mas_equalTo(standardHipline.mas_width);
        make.bottom.mas_equalTo(standardHipline.mas_top);
    }];
    _hiplineLabel  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"99.3cm" textColor:RGB(67, 207, 124) textAlignment:NSTextAlignmentCenter font:MediumFont(20)];
    [self.contentView addSubview:_hiplineLabel];
    [_hiplineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hiplineHint.mas_height);
        make.left.mas_equalTo(hiplineHint.mas_left);
        make.width.mas_equalTo(hiplineHint.mas_width);
        make.bottom.mas_equalTo(hiplineHint.mas_top);
    }];
}

-(void)setPkInfoModel:(CSPKInfoModel *)pkInfoModel {
    _pkInfoModel = pkInfoModel;
    _standardChest.text = isEmptyStr(pkInfoModel.normChestWai)?@"标准胸围":[NSString stringWithFormat:@"标准胸围：%@",pkInfoModel.normChestWai];
    _chestlabel.text = pkInfoModel.myInfo.chestWai;
    _standardWaistline.text = isEmptyStr(pkInfoModel.normWaistWai)?@"标准腰围":[NSString stringWithFormat:@"标准腰围：%@",pkInfoModel.normWaistWai];
    _waistlineLabel.text = pkInfoModel.myInfo.waistWai;
    
    _standardHipline.text = isEmptyStr(pkInfoModel.normHipWai)?@"标准臀围":[NSString stringWithFormat:@"标准臀围：%@",pkInfoModel.normHipWai];
    _hiplineLabel.text = pkInfoModel.myInfo.hipWai;
}

@end
