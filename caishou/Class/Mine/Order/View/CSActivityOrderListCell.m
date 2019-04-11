//
//  CSActivityOrderListCell.m
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSActivityOrderListCell.h"

@implementation CSActivityOrderListCell
{
    UILabel *statusLabel;
    UIImageView *goodsImageView;
    UILabel *goodsNameLabel;
    UILabel *areaLabel;
    UILabel *desLabel;
    UILabel *totalPriceLabel;
    
    NSMutableArray  *btnArrayM;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
        btnArrayM = [NSMutableArray new];
        [self creatUI];
    }
    return self;
}

- (void )creatUI{

    statusLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"text" textColor:RGBA(237, 130, 32, 1) textAlignment:Right font:RegularFont(14)];
    [self.contentView addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(SIZE(15));
        make.height.offset(SIZE(30));
    }];
    
    UIView *bgView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self->statusLabel.mas_bottom).offset(0);
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
    
    goodsNameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"text" textColor:RGB44 textAlignment:Left font:MediumFont(14)];
    goodsNameLabel.numberOfLines = 2;
    [bgView addSubview:goodsNameLabel];
    [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->goodsImageView.mas_right).offset(SIZE(20));
        make.top.mas_equalTo(self->goodsImageView.mas_top).offset(0);
//        make.height.offset(SIZE(30));
        make.right.offset(-SIZE(15));
    }];
    
    
    desLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"text\ntext\ntext" textColor:RGB102 textAlignment:Left font:RegularFont(12)];
    desLabel.numberOfLines = 4;
    [bgView addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->goodsImageView.mas_right).offset(SIZE(20));
        make.top.mas_equalTo(self->goodsNameLabel.mas_bottom).offset(SIZE(5));
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
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [ViewCreate createButtonFrame:CGRectMake(SCREEN_WIDTH-SIZE(15)-width*(i+1)-SIZE(10)*i, SIZE(7), width, SIZE(30)) title:(i==1)?@"取消订单":@"去支付" titleColor:RGB102 font:RegularFont(15) backgroundColor:ClearColor touchUpInsideEvent:nil];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = SIZE(15);
        btn.layer.borderColor = RGB153.CGColor;
        btn.layer.borderWidth = 1;
        //        btn.hidden = YES;
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:btn];
        [btnArrayM addObject:btn];
    }
    
}
- (void )clickBtn:(UIButton *)sender{
    //按钮从右往左
    switch (sender.tag) {
        case 0:
        {
            BOOL isNeePay ;
            if ([_order.appStatus isEqualToString:@"1"]) {
                //未支付去支付
                isNeePay = YES;
            }else{
                isNeePay = NO;
            }
            
            if (self.btnClickBlock) {
                self.btnClickBlock(NO, self.order.ID, isNeePay);
            }
        }
            
            break;
        case 1:
            //取消订单
            if (self.btnClickBlock) {
                self.btnClickBlock(YES, self.order.ID, NO);
            }
            break;
       
        
        default:
            break;
    }
}
-(void)setOrder:(CSActivityOrderListModel *)order{
    _order = order;
    //    活动状态（1:未开始;2:进行中;3:已结束;）
    if ([_order.appActivityStatus isEqualToString:@"1"]) {
        statusLabel.text = @"未开始";
        statusLabel.textColor = RGBA(237, 130, 32, 1);
    }
    else if ([_order.appActivityStatus isEqualToString:@"2"]) {
        statusLabel.text = @"进行中";
        statusLabel.textColor = RGBA(237, 130, 32, 1);
    }
    
    else if ([_order.appActivityStatus isEqualToString:@"9"]) {
        statusLabel.text = @"已结束";
        statusLabel.textColor = RGB153;
    }
    [goodsImageView sd_setImageWithURL:[NSURL URLWithString:_order.img] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    goodsNameLabel.text = isEmptyStr(_order.activityTitle)?@"":[NSString stringWithFormat:@"%@",_order.activityTitle];
    desLabel.text = [NSString stringWithFormat:@"地址：%@\n开始时间：%@\n结束时间：%@",isEmptyStr(_order.clubAddress)?@"":_order.clubAddress,isEmptyStr(_order.strStartTime)?@"":_order.strStartTime,isEmptyStr(_order.strEndTime)?@"":_order.strEndTime];
    totalPriceLabel.text = [NSString stringWithFormat:@"合计：%@%@",_order.price,[_order.signType isEqualToString:@"1"]?@"元":@"莱币"];//signType参与方式(1:金额;2:积分)
    
    
    UIButton *btn = btnArrayM[1];
    if ([_order.appActivityStatus isEqualToString:@"1"]) {
        //活动未开始可以取消订单
        btn.hidden = NO;
    }else{
        btn.hidden = YES;
    }
    
    //报名状态（1:未支付;2:已支付;）
    UIButton *btn1 = btnArrayM[0];
    if ([_order.appStatus isEqualToString:@"1"]) {
        //未支付去支付
        [btn1 setTitle:@"去支付" forState:UIControlStateNormal];
    }else{
        [btn1 setTitle:@"联系客服" forState:UIControlStateNormal];
    }
    
}
@end
