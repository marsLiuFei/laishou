//
//  CSPassowrdCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/13.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSPassowrdCell.h"

@interface CSPassowrdCell ()
{
    UILabel *_titleLabel;
    UITextField *_textField;
}

@end

@implementation CSPassowrdCell

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
        make.width.mas_equalTo(SIZE(80));
    }];
    _textField = [ViewCreate createTextFieldFrame:CGRectMake(0, 0, 0, 0) font:RegularFont(15) textColor:[UIColor blackColor] placeHolder:@"" delegate:nil];
     _textField.secureTextEntry = true;
    [self.contentView addSubview:_textField];
    [_textField addTarget:self action:@selector(fieldChange:) forControlEvents:UIControlEventEditingChanged];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_titleLabel.mas_right).offset(SIZE(5));
        make.centerY.offset(0);
        make.height.offset(SIZE(50));
    }];
}

- (void)setPassModel:(CSPasswordModel *)passModel {
    _passModel = passModel;
    _textField.placeholder = passModel.placeholder;
    _titleLabel.text = passModel.title;
}

#pragma mark - change
-(void)fieldChange:(UITextField *)textField  {
    NSLog(@"textField.text = %@" , textField.text);
    self.passModel.inputData = textField.text;
}





@end
