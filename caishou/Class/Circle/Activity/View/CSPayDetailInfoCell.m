//
//  CSPayDetailInfoCell.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/16.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSPayDetailInfoCell.h"

@implementation CSPayDetailInfoCell
{
    UILabel *paymentLabel;//支付方式
    UIButton *choosePayModeBtn;
    UIImageView *goodsImageView;
    UILabel *titleLabel;
    UILabel *desLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}

- ( void )creatUI{
    paymentLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"支付方式" textColor:RGB102 textAlignment:Left font:RegularFont(12)];
    [self.contentView addSubview:paymentLabel];
    [paymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.top.offset(0);
        make.height.offset(SIZE(30));
    }];
    
    choosePayModeBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"微信支付···" titleColor:RGBA(237, 130, 32, 1) font:MediumFont(SIZE(14)) backgroundColor:ClearColor touchUpInsideEvent:nil];
    [choosePayModeBtn addTarget:self action:@selector(choosPayModeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:choosePayModeBtn];
    [choosePayModeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.height.offset(SIZE(30));
        make.right.offset(-SIZE(15));
    }];
    
    
    
    UIView *line = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(234, 234, 234)];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self->paymentLabel.mas_bottom).offset(0);
        make.height.offset(SIZE(1));
    }];
    
    
    goodsImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self.contentView addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(SIZE(100));
        make.height.offset(SIZE(80));
        make.left.offset(SIZE(15));
        make.top.mas_equalTo(line.mas_bottom).offset(SIZE(15));
    }];
    
    titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"2019年蜀山半程马拉松赛团报" textColor:RGB44 textAlignment:Left font:MediumFont(14)];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->goodsImageView.mas_right).offset(SIZE(20));
        make.right.offset(-SIZE(15));
        make.top.mas_equalTo(self->goodsImageView.mas_top).offset(0);
    }];
    
    
    desLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"地址：蜀山区\n开始时间：2019-03-01\n结束时间：2019-05-01" textColor:RGB102 textAlignment:Left font:MediumFont(12)];
    desLabel.numberOfLines = 3;
    [self.contentView addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->goodsImageView.mas_right).offset(SIZE(20));
        make.right.offset(-SIZE(15));
        make.bottom.mas_equalTo(self->goodsImageView.mas_bottom).offset(0);
    }];
    
}
-(void)setActivityDetailModel:(CSActivityDetailModel *)activityDetailModel{
    _activityDetailModel = activityDetailModel;
    [goodsImageView sd_setImageWithURL:[NSURL URLWithString:_activityDetailModel.img] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    titleLabel.text = isEmptyStr(_activityDetailModel.activityTitle)?@"":_activityDetailModel.activityTitle;
    desLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@",[NSString stringWithFormat:@"地址：%@",isEmptyStr(_activityDetailModel.clubAddress)?@"":_activityDetailModel.clubAddress],[NSString stringWithFormat:@"开始时间：%@",isEmptyStr(_activityDetailModel.strStartTime)?@"":_activityDetailModel.strStartTime],[NSString stringWithFormat:@"结束时间：%@",isEmptyStr(_activityDetailModel.strEndTime)?@"":_activityDetailModel.strEndTime]];
}

-(void )choosPayModeBtnClick{
    if (self.choosePayModeBlock) {
        self.choosePayModeBlock();
    }
}
-(void)setPayMode:(NSString *)payMode{
    _payMode = payMode;
    [choosePayModeBtn setTitle:[NSString stringWithFormat:@"%@···",_payMode] forState:UIControlStateNormal];
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
