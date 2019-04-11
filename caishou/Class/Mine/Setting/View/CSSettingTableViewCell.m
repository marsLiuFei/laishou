//
//  CSSettingTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/12.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSSettingTableViewCell.h"

@interface CSSettingTableViewCell ()
{
    UILabel *_titleLabel;
    UILabel *_subLabel;
    UIImageView *_accessIcon;
}

@end

@implementation CSSettingTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
    _titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB(53, 60, 54) textAlignment:Left font:RegularFont(16)];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.centerY.offset(0);
    }];
    
    _accessIcon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"arrow_right"];
    [self.contentView addSubview:_accessIcon];
    [_accessIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZE(15));
        make.centerY.offset(0);
        make.height.width.offset(SIZE(12));
    }];
    _subLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB(153,153,153) textAlignment:Right font:RegularFont(12)];
    [self.contentView addSubview:_subLabel];
    [_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->_accessIcon.mas_left).offset(-SIZE(5));
        make.centerY.offset(0);
    }];
    UIView *bottomLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(236, 236, 236)];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(SIZE(0.5));
    }];
}
- (void)setSettingModel:(CSSettingModel *)settingModel {
    _settingModel = settingModel;
    _titleLabel.text = settingModel.title;
    _subLabel.text = settingModel.subTitle;
}

@end
