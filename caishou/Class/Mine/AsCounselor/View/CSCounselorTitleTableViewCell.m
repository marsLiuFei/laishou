//
//  CSCounselorTitleTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/23.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCounselorTitleTableViewCell.h"

@implementation CSCounselorTitleTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
    
    UILabel *headerLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"头像" textColor:RGB(51, 51, 51) textAlignment:Center font:MediumFont(14)];
    [self.contentView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.width.offset(SIZE(50));
        make.centerY.offset(0);
    }];
    
    UILabel *nameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"昵称" textColor:RGB(51, 51, 51) textAlignment:Center font:MediumFont(14)];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerLabel.mas_right);
        make.top.bottom.mas_offset(0);
        make.width.offset(SIZE(50));
    }];
    UILabel *phoneLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"手机" textColor:RGB(51,51,51) textAlignment:Center font:MediumFont(14)];
    [self.contentView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_right);
        make.top.bottom.mas_offset(0);
        make.width.offset(SIZE(120));
    }];
    UILabel *weightLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"体重" textColor:RGB(51,51,51) textAlignment:Center font:MediumFont(14)];
    [self.contentView addSubview:weightLabel];
    [weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel.mas_right);
        make.top.bottom.mas_offset(0);
        make.width.offset(SIZE(60));
    }];
    UILabel *bmiLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"BMI值" textColor:RGB(51,51,51) textAlignment:Left font:MediumFont(14)];
    [self.contentView addSubview:bmiLabel];
    [bmiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weightLabel.mas_right).offset(SIZE(15));
        make.top.bottom.mas_offset(0);
        make.width.offset(SIZE(60));
    }];
}



@end
