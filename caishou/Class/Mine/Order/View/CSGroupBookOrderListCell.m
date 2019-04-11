//
//  CSGroupBookOrderListCell.m
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSGroupBookOrderListCell.h"

@implementation CSGroupBookOrderListCell
{
    UILabel *orderNoLabel;
    UILabel *statusLabel;
    UIImageView *goodsImageView;
    UILabel *goodsNameLabel;
    UILabel *priceLabel;
    UILabel *totalPriceLabel;
    
    UIButton *btn;
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
    
    UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGBA(238, 238, 238, 1)];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self->orderNoLabel.mas_bottom).offset(0);
        make.height.offset(SIZE(105));
    }];
    
    
    goodsImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [bgView addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.centerY.offset(0);
        make.width.offset(SIZE(100));
        make.height.offset(SIZE(85));
    }];
    
    priceLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"text" textColor:RGB102 textAlignment:Left font:RegularFont(12)];
    [bgView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->goodsImageView.mas_right).offset(SIZE(20));
        make.bottom.mas_equalTo(self->goodsImageView.mas_bottom).offset(0);
        make.height.offset(SIZE(28));
        make.right.offset(-SIZE(15));
    }];
    
    
    goodsNameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"text" textColor:RGB44 textAlignment:Left font:MediumFont(14)];
    goodsNameLabel.numberOfLines = 2;
    [bgView addSubview:goodsNameLabel];
    [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->goodsImageView.mas_right).offset(SIZE(20));
        make.top.mas_equalTo(self->goodsImageView.mas_top).offset(0);
        make.bottom.mas_equalTo(self->priceLabel.mas_top).offset(0);
        make.right.offset(-SIZE(15));
    }];
    
    totalPriceLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"text" textColor:RGB102 textAlignment:Right font:RegularFont(14)];
    [self.contentView addSubview:totalPriceLabel];
    [totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.right.offset(-SIZE(15));
        make.top.mas_equalTo(bgView.mas_bottom).offset(0);
        make.height.offset(SIZE(30));
        
    }];
    
    UIView *line1 = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGBA(234, 234, 234, 1)];
    [self.contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self->totalPriceLabel.mas_bottom).offset(0);
        make.height.offset(SIZE(1));
    }];
    
    
    UIView *bottomView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.mas_equalTo(line1.mas_bottom).offset(0);
        make.height.offset(SIZE(44));
    }];
    
    
    CGFloat width = (SCREEN_WIDTH-SIZE(60))/4.f;
    btn = [ViewCreate createButtonFrame:CGRectMake(SCREEN_WIDTH-SIZE(15)-width, SIZE(7), width, SIZE(30)) title:@"取消" titleColor:RGB102 font:RegularFont(15) backgroundColor:ClearColor touchUpInsideEvent:nil];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = SIZE(15);
    btn.layer.borderColor = RGB153.CGColor;
    btn.layer.borderWidth = 1;
    btn.hidden = YES;
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btn];
}
- (void )clickBtn:(UIButton *)sender{
    if ([_orderModel.spellStatus isEqualToString:@"3"]){
        //删除按钮
        if (self.btnClickBlock) {
            self.btnClickBlock(NO, self.orderModel.ID,_orderModel.goodsName,_orderModel.ID);
        }
    }else{
        //分享按钮
        if (self.btnClickBlock) {
            self.btnClickBlock(YES, self.orderModel.goodsId,_orderModel.goodsName,_orderModel.ID);
        }
    }
    
    
}
-(void)setOrderModel:(CSGroupBookOrderListModel *)orderModel{
    _orderModel = orderModel;
    orderNoLabel.text = isEmptyStr(_orderModel.indentCode)?@"":[NSString stringWithFormat:@"订单号：%@",_orderModel.indentCode];
    
    //    拼团状态（1:拼团中;2:拼团成功;3:已领取）
    if ([_orderModel.spellStatus isEqualToString:@"1"]) {
        statusLabel.text = @"拼团中";
        statusLabel.textColor = RGBA(237, 130, 32, 1);
    }
    else if ([_orderModel.spellStatus isEqualToString:@"2"]) {
        statusLabel.text = @"拼团成功";
        statusLabel.textColor = RGBA(237, 130, 32, 1);
    }
    else if ([_orderModel.spellStatus isEqualToString:@"3"]) {
        statusLabel.text = @"已领取";
        statusLabel.textColor = RGBA(237, 130, 32, 1);
    }
    
    
    [goodsImageView sd_setImageWithURL:[NSURL URLWithString:_orderModel.goodsUrl] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    goodsNameLabel.text = isEmptyStr(_orderModel.goodsName)?@"":[NSString stringWithFormat:@"%@",_orderModel.goodsName];
    
    priceLabel.text = isEmptyStr(_orderModel.number)?@"":[NSString stringWithFormat:@"数量：%@个",_orderModel.number];
    totalPriceLabel.text = [NSString stringWithFormat:@"合计：%@元",_orderModel.totalPrice];
    
    
    if ([_orderModel.spellStatus isEqualToString:@"2"]){
        //拼团成功隐藏按钮
        btn.hidden = YES;
    }else{
        //显示
        btn.hidden = NO;
        if ([_orderModel.spellStatus isEqualToString:@"3"]){
            //删除按钮
            [btn setTitle:@"取消订单" forState:UIControlStateNormal];
        }else{
            //分享按钮
            [btn setTitle:@"分享" forState:UIControlStateNormal];
        }
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
