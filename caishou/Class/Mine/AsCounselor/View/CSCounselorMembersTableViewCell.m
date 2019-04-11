//
//  CSCounselorMembersTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/23.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCounselorMembersTableViewCell.h"

@interface CSCounselorMembersTableViewCell ()
{
    UIImageView *_headerImageView;
    UILabel *_nameLabel;
    UILabel *_phoneLabel;
    UILabel *_weightLabel;
    UILabel *_bmiLabel;
}

@end

@implementation CSCounselorMembersTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
    
    _headerImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"counselor"];
    [self.contentView addSubview:_headerImageView];
    _headerImageView.clipsToBounds = true;
    _headerImageView.layer.cornerRadius = SIZE(40)* 0.5;
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.width.height.offset(SIZE(40));
        make.centerY.offset(0);
    }];
    
    _nameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"小灰灰" textColor:RGB(102, 102, 102) textAlignment:Center font:MediumFont(14)];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_headerImageView.mas_right).offset(SIZE(10));
        make.top.bottom.mas_offset(0);
        make.width.offset(SIZE(50));
    }];
    _phoneLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"15666666666" textColor:RGB(102,102,102) textAlignment:Center font:RegularFont(12)];
    [self.contentView addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_nameLabel.mas_right);
        make.top.bottom.mas_offset(0);
        make.width.offset(SIZE(120));
    }];
    
    _weightLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"95kg" textColor:RGB(67,207,124) textAlignment:Center font:RegularFont(12)];
    [self.contentView addSubview:_weightLabel];
    [_weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_phoneLabel.mas_right);
        make.top.bottom.mas_offset(0);
        make.width.offset(SIZE(60));
    }];
    
    _bmiLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"28.5" textColor:RGB(237,130,32) textAlignment:Center font:RegularFont(12)];
    [self.contentView addSubview:_bmiLabel];
    [_bmiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_weightLabel.mas_right).offset(SIZE(15));
        make.top.bottom.mas_offset(0);
        make.width.offset(SIZE(60));
    }];
    UIView *line1 = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGBA(234, 234, 234, 1)];
    [self.contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(SIZE(-1));
        make.height.offset(SIZE(1));
    }];
}

-(void)setUserModel:(CSUserMemberModel *)userModel {
    _userModel = userModel;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:userModel.headImg]];
    _nameLabel.text = isEmptyStr(userModel.name)?@"暂无":userModel.name;
    if (self.show) {
        NSString *phone = userModel.mobile;
        if (phone.length > 6) {
            NSString *replaceStr = [phone substringWithRange:NSMakeRange(3, 6)];
            _phoneLabel.text = [phone stringByReplacingOccurrencesOfString:replaceStr withString:@"******"];
        }else {
          _phoneLabel.text = @"***********";
        }
    }else {
      _phoneLabel.text = userModel.mobile;
    }
   
    _weightLabel.text = isEmptyStr(userModel.weight)?@"0.0kg":[NSString stringWithFormat:@"%@kg",userModel.weight];
    _bmiLabel.text = isEmptyStr(userModel.bmi)?@"0.0":userModel.bmi;
}
- (void)setBlack:(BOOL)black {
    _black = black;
    if (black) {
        _weightLabel.textColor = RGB(102,102,102);
        _bmiLabel.textColor = RGB(102,102,102);
    }
}

@end
