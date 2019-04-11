//
//  CSInputTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/4.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSInputTableViewCell.h"

@interface CSInputTableViewCell ()
{
    UIImageView *_leftImageView;
    UILabel *_titleLabel;
    UITextField *_inputField;
}

@end

@implementation CSInputTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = WhiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}
#pragma mark - setupUI
- (void)setupUI {
    _leftImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"name"];
    [self.contentView addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(SIZE(17));
    }];
    _titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"姓名" textColor:RGB(102, 102, 102) textAlignment:Left font:MediumFont(16)];
    _titleLabel.numberOfLines = 2;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self -> _leftImageView.mas_right).offset(SIZE(13));
        make.width.offset(SIZE(120));
        make.top.bottom.offset(0);
    }];
    _inputField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _inputField.placeholder = @"请输入您的姓名";
    [_inputField addTarget:self action:@selector(inputField:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_inputField];
    _inputField.font = RegularFont(13);
    [_inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.offset(-15);
        make.left.mas_equalTo(self -> _titleLabel.mas_right);
    }];
}
- (void)setModel:(CSInfoModel *)model {
    _model = model;
    _leftImageView.image = [UIImage imageNamed:model.iconStr];
    _titleLabel.text = model.title;
    _inputField.placeholder = model.placeholder;
    _inputField.text = model.text;
    _inputField.tag = model.tag;
}

- (void)inputField:(UITextField *)field {
    self.model.text = field.text;
}

@end
