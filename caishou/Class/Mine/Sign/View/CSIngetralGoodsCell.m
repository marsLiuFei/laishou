//
//  CSIngetralGoodsCell.m
//  caishou
//
//  Created by 刘飞 on 2019/3/1.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSIngetralGoodsCell.h"

@implementation CSIngetralGoodsCell
{
    UIImageView *goodsImageView;
    UILabel *goodsNameLabel;
    UILabel *priceLabel;
    UIButton *bugBtn;//兑换按钮
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}

- (void )creatUI{
    goodsImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self.contentView addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.height.offset(SIZE(150));
        make.width.offset(SIZE(160));
        make.top.offset(SIZE(13));
    }];
    
    goodsNameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"YSL圣罗兰黑管唇釉" textColor:RGB102 textAlignment:Left font:MediumFont(14)];
    [self.contentView addSubview:goodsNameLabel];
    [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->goodsImageView.mas_bottom).offset(SIZE(13));
        make.left.mas_equalTo(self->goodsImageView.mas_left).offset(0);
        make.height.offset(SIZE(20));
    }];
    
    
    bugBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"兑换" titleColor:WhiteColor font:RegularFont(12) backgroundColor:MainColor touchUpInsideEvent:nil];
    [bugBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    bugBtn.layer.masksToBounds = YES;
    bugBtn.layer.cornerRadius = SIZE(5);
    [self.contentView addSubview:bugBtn];
    [bugBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZE(15));
        make.top.mas_equalTo(self->goodsNameLabel.mas_bottom).offset(SIZE(10));
        make.width.offset(SIZE(50));
        make.height.offset(SIZE(20));
    }];
    
    
    
    priceLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"10000莱币" textColor:RGBA(237, 130, 32,1) textAlignment:Left font:RegularFont(12)];
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->goodsNameLabel.mas_bottom).offset(SIZE(10));
        make.left.mas_equalTo(self->goodsNameLabel.mas_left).offset(0);
        make.right.mas_equalTo(self->bugBtn.mas_left).offset(-SIZE(10));
    }];
    
    
}

-(void)setIntegralGoodsModel:(CSIntegralGoodsModel *)integralGoodsModel{
    _integralGoodsModel = integralGoodsModel;
    [goodsImageView sd_setImageWithURL:[NSURL URLWithString:_integralGoodsModel.goodsImg] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    goodsNameLabel.text = isEmptyStr(_integralGoodsModel.goodsName)?@"":_integralGoodsModel.goodsName;
    priceLabel.text = isEmptyStr(_integralGoodsModel.integral)?@"":[NSString stringWithFormat:@"%@莱币",_integralGoodsModel.integral];
}

- (void )clickBtn{
    if (self.clickBtnBlock) {
        self.clickBtnBlock(self.integralGoodsModel.ID);
    }
}

@end
