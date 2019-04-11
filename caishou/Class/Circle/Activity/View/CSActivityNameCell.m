//
//  CSActivityNameCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSActivityNameCell.h"

@implementation CSActivityNameCell
{
    UILabel *activityNameLabel;//活动名称
//    UIButton *viewCountBtn;
//    UIButton *sharebtn;
//    UIButton *collectbtn;
    
//    UIButton *dealbtn;
//    UIButton *refundbtn;//退款
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}
- (void )creatUI{
    activityNameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"2019蜀山半程马拉松赛团报" textColor:BlackColor textAlignment:Left font:MediumFont(17)];
    activityNameLabel.numberOfLines = 0;
    [self.contentView addSubview:activityNameLabel];
    [activityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(SIZE(15));
        make.right.offset(-SIZE(15));
    }];
    
//    viewCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [viewCountBtn setTitle:@"2073" forState:UIControlStateNormal];
//    [viewCountBtn setTitleColor:RGB(102,102,102) forState:UIControlStateNormal];
//    viewCountBtn.titleLabel.font = FONT(12);
//    [viewCountBtn setImage:[UIImage imageNamed:@"circle_viewcount"] forState:UIControlStateNormal];
//    [viewCountBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -viewCountBtn.titleLabel.bounds.size.width)];
//    [self.contentView addSubview:viewCountBtn];
//    [viewCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(SIZE(15));
//        make.top.mas_equalTo(self->activityNameLabel.mas_bottom).offset(SIZE(15));
//        make.height.offset(SIZE(20));
//    }];
//    
//    sharebtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [sharebtn setTitle:@"73" forState:UIControlStateNormal];
//    [sharebtn setTitleColor:RGB(102,102,102) forState:UIControlStateNormal];
//    sharebtn.titleLabel.font = FONT(12);
//    [sharebtn setImage:[UIImage imageNamed:@"circle_share"] forState:UIControlStateNormal];
//    [sharebtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -sharebtn.titleLabel.bounds.size.width)];
//    [self.contentView addSubview:sharebtn];
//    [sharebtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->viewCountBtn.mas_right).offset(SIZE(15));
//        make.top.mas_equalTo(self->activityNameLabel.mas_bottom).offset(SIZE(15));
//        make.height.offset(SIZE(20));
//    }];
//    
//    
//    collectbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [collectbtn setTitle:@"13" forState:UIControlStateNormal];
//    [collectbtn setTitleColor:RGB(102,102,102) forState:UIControlStateNormal];
//    collectbtn.titleLabel.font = FONT(12);
//    [collectbtn setImage:[UIImage imageNamed:@"circle_collect"] forState:UIControlStateNormal];
//    [collectbtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -collectbtn.titleLabel.bounds.size.width)];
//    [self.contentView addSubview:collectbtn];
//    [collectbtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->sharebtn.mas_right).offset(SIZE(15));
//        make.top.mas_equalTo(self->activityNameLabel.mas_bottom).offset(SIZE(15));
//        make.height.offset(SIZE(20));
//    }];
//    
//    
//    
//    
//    refundbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [refundbtn setTitle:@"支持退款" forState:UIControlStateNormal];
//    [refundbtn setTitleColor:RGBA(128, 181, 26, 1) forState:UIControlStateNormal];
//    refundbtn.titleLabel.font = FONT(12);
//    [refundbtn setImage:[UIImage imageNamed:@"circle_success"] forState:UIControlStateNormal];
//    [refundbtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -refundbtn.titleLabel.bounds.size.width)];
//    [self.contentView addSubview:refundbtn];
//    [refundbtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(-SIZE(15));
//        make.top.mas_equalTo(self->activityNameLabel.mas_bottom).offset(SIZE(15));
//        make.height.offset(SIZE(20));
//    }];
//    
//    
//    dealbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [dealbtn setTitle:@"支持退款" forState:UIControlStateNormal];
//    [dealbtn setTitleColor:RGBA(128, 181, 26, 1) forState:UIControlStateNormal];
//    dealbtn.titleLabel.font = FONT(12);
//    [dealbtn setImage:[UIImage imageNamed:@"circle_success"] forState:UIControlStateNormal];
//    [dealbtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -dealbtn.titleLabel.bounds.size.width)];
//    [self.contentView addSubview:dealbtn];
//    [dealbtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self->refundbtn.mas_left).offset(-SIZE(15));
//        make.top.mas_equalTo(self->activityNameLabel.mas_bottom).offset(SIZE(15));
//        make.height.offset(SIZE(20));
//    }];
    
}
-(void)setTitleName:(NSString *)titleName{
    _titleName = titleName;
    activityNameLabel.text = isEmptyStr(_titleName)?@"":_titleName;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
