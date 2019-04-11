//
//  CSMessageSettingCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/14.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSMessageSettingCell.h"

@interface CSMessageSettingCell ()
{
    UILabel *_subLabel;
    UILabel *_titleLabel;
    UISwitch *_switch;
}

@end

@implementation CSMessageSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

#pragma mark - setupUI
- (void)setupUI {
    _titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB(53, 60, 54) textAlignment:Left font:RegularFont(16)];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.centerY.offset(0);
    }];
   _subLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB(153, 153, 153) textAlignment:Right font:RegularFont(12)];
    [self.contentView addSubview:_subLabel];
    [_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(SIZE(-15));
        make.centerY.offset(0);
    }];
    _switch = [[UISwitch alloc] init];
    _switch.transform = CGAffineTransformMakeScale( 0.8, 0.7);
    [self.contentView addSubview:_switch];
    [_switch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(SIZE(-15));
        make.centerY.offset(0);
    }];
}
- (void)setSettingModel:(CSMessageSettingModel *)settingModel {
    _settingModel = settingModel;
    _titleLabel.text = settingModel.title;
    _subLabel.text = settingModel.subTitle;
    if (settingModel.showBtn) {
        _subLabel.hidden = true;
        _switch.hidden = false;
    }else {
        _subLabel.hidden = false;
        _switch.hidden = true;
    }
}


@end
