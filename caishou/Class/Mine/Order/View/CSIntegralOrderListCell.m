//
//  CSIntegralOrderListCell.m
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSIntegralOrderListCell.h"

@implementation CSIntegralOrderListCell
{
    UILabel *orderNoLabel;
    UILabel *statusLabel;
    UIImageView *goodsImageView;
    UILabel *goodsNameLabel;
    UILabel *skuLabel;
    UILabel *priceLabel;
    UILabel *totalPriceLabel;
    UIView *bottomView;
    UIButton *cancelBtn;
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
    orderNoLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"text" textColor:RGB102 textAlignment:Left font:RegularFont(14)];
    [self.contentView addSubview:orderNoLabel];
    [orderNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(SIZE(15));
        make.height.offset(SIZE(30));
    }];
    
    statusLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"text" textColor:RGBA(237, 130, 32, 1) textAlignment:Right font:RegularFont(14)];
    [self.contentView addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
         make.right.offset(-SIZE(15));
        make.height.offset(SIZE(30));
    }];
    
    goodsImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self.contentView addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.top.mas_equalTo(self->orderNoLabel.mas_bottom).offset(SIZE(10));
        make.width.height.offset(SIZE(85));
    }];
    
    
    goodsNameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"text" textColor:RGB44 textAlignment:Left font:MediumFont(14)];
    [self.contentView addSubview:goodsNameLabel];
    [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->goodsImageView.mas_right).offset(SIZE(20));
        make.top.mas_equalTo(self->goodsImageView.mas_top).offset(0);
        make.height.offset(SIZE(28));
        make.right.offset(-SIZE(15));
    }];
    
    skuLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"text" textColor:RGB102 textAlignment:Left font:RegularFont(12)];
    [self.contentView addSubview:skuLabel];
    [skuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->goodsImageView.mas_right).offset(SIZE(20));
        make.centerY.mas_equalTo(self->goodsImageView.mas_centerY).offset(0);
        make.height.offset(SIZE(28));
        make.right.offset(-SIZE(15));
    }];
    
    priceLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"text" textColor:RGB102 textAlignment:Left font:RegularFont(12)];
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->goodsImageView.mas_right).offset(SIZE(20));
        make.bottom.mas_equalTo(self->goodsImageView.mas_bottom).offset(0);
        make.height.offset(SIZE(28));
        make.right.offset(-SIZE(15));
    }];
    
    
    totalPriceLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"text" textColor:RGB102 textAlignment:Right font:RegularFont(14)];
    [self.contentView addSubview:totalPriceLabel];
    [totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.right.offset(-SIZE(15));
        make.top.mas_equalTo(self->goodsImageView.mas_bottom).offset(SIZE(10));
        make.height.offset(SIZE(30));
        
    }];
    
    
    
    
    bottomView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self->totalPriceLabel.mas_bottom).offset(0);
        make.height.offset(SIZE(44));
    }];
    UIView *line1 = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGBA(234, 234, 234, 1)];
    [bottomView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.offset(SIZE(1));
    }];
    
    
    CGFloat width = (SCREEN_WIDTH-SIZE(60))/4.f;
    cancelBtn = [ViewCreate createButtonFrame:CGRectMake(SCREEN_WIDTH-SIZE(15)-width*1, SIZE(7), width, SIZE(30)) title:@"取消订单" titleColor:RGB102 font:RegularFont(15) backgroundColor:ClearColor touchUpInsideEvent:nil];
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = SIZE(15);
    cancelBtn.layer.borderColor = RGB153.CGColor;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.hidden = YES;
    [cancelBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancelBtn];
    
    
}
- (void )clickBtn:(UIButton *)sender{
    //取消
    if (self.cancelBtnClickBlock) {
        self.cancelBtnClickBlock(self.orderModel.ID);
    }
}



-(void)setOrderModel:(CSIntegralOrderListModel *)orderModel{
    _orderModel = orderModel;
    
    orderNoLabel.text = isEmptyStr(_orderModel.indentCode)?@"":[NSString stringWithFormat:@"订单号：%@",_orderModel.indentCode];
    
//    (1:未领取;2:已领取;3:不能领取;9:删除)
    if ([_orderModel.status isEqualToString:@"1"]) {
        statusLabel.text = @"未领取";
        statusLabel.textColor = RGBA(237, 130, 32, 1);
    }
    else if ([_orderModel.status isEqualToString:@"2"]) {
        statusLabel.text = @"已领取";
        statusLabel.textColor = RGBA(237, 130, 32, 1);
    }
    else if ([_orderModel.status isEqualToString:@"3"]) {
        statusLabel.text = @"领取失败";
        statusLabel.textColor = RGBA(236, 26, 26, 1);
    }
    else if ([_orderModel.status isEqualToString:@"9"]) {
        statusLabel.text = @"已取消";
        statusLabel.textColor = RGB153;
    }
    
    [goodsImageView sd_setImageWithURL:[NSURL URLWithString:_orderModel.goodsImg] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    goodsNameLabel.text = isEmptyStr(_orderModel.goodsName)?@"":[NSString stringWithFormat:@"%@",_orderModel.goodsName];
    skuLabel.text = isEmptyStr(_orderModel.number)?@"":[NSString stringWithFormat:@"数量：%@",_orderModel.number];
    priceLabel.text = isEmptyStr(_orderModel.integral)?@"":[NSString stringWithFormat:@"单价：%@莱币",_orderModel.integral];
    totalPriceLabel.text = [NSString stringWithFormat:@"总价：%.2lf莱币",[_orderModel.number integerValue]*[_orderModel.integral floatValue]];
    
    if ([_orderModel.status isEqualToString:@"1"]) {
        cancelBtn.hidden = YES;
        bottomView.hidden = YES;
    }else{
        cancelBtn.hidden = NO;
    }
    
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
