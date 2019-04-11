//
//  CSFitGoodsCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/27.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSFitGoodsCell.h"

@interface CSFitGoodsCell ()
@end
@implementation CSFitGoodsCell
{
    UIImageView *goodsImageView;
    UILabel *goodsNameLabel;
    UILabel *desLabel;
    
    UILabel *doneNumLabel;//已完成
    UILabel *leftNumLabel;//剩余
    
    UILabel *priceLabel;
    UILabel *marketPriceLabel;
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
    goodsImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self.contentView addSubview:goodsImageView];
    [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(SIZE(130));
        make.centerY.offset(0);
        make.left.offset(SIZE(15));
    }];
    
    goodsNameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"[新用户专享]黑茶牙膏免费领取，先到先得..." textColor:RGB44 textAlignment:Left font:[UIFont fontWithName:@"PingFangSC-Regular" size: SIZE(16)]];
    [self.contentView addSubview:goodsNameLabel];
    [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->goodsImageView.mas_top).offset(0);
        make.left.mas_equalTo(self->goodsImageView.mas_right).offset(SIZE(20));
        make.right.offset(-SIZE(15));
    }];
    
    
    desLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"国产 120g/盒" textColor:RGB102 textAlignment:Left font:FONT(12)];
    [self.contentView addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->goodsNameLabel.mas_bottom).offset(SIZE(15));
        make.left.mas_equalTo(self->goodsImageView.mas_right).offset(SIZE(20));
        make.right.offset(-SIZE(15));
    }];
    
    
    UIView *numBgView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor];
    numBgView.layer.masksToBounds = YES;
    numBgView.layer.cornerRadius = SIZE(10);
    numBgView.layer.borderColor = RGBA(237, 130, 32, 1).CGColor;
    numBgView.layer.borderWidth = SIZE(0.5);
    [self.contentView addSubview:numBgView];
    [numBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->goodsImageView.mas_right).offset(SIZE(20));
        make.top.mas_equalTo(self->desLabel.mas_bottom).offset(SIZE(15));
        make.height.offset(SIZE(20));
    }];
    
    
    doneNumLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"  已团1300份  " textColor:RGBA(237, 130, 32, 1) textAlignment:Left font:FONT(12)];
    [numBgView addSubview:doneNumLabel];
    [doneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
    }];
    
    leftNumLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGBA(237, 130, 32, 1) text:@"  剩余20份  " textColor:WhiteColor textAlignment:Left font:FONT(12)];
    [numBgView addSubview:leftNumLabel];
    [leftNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.left.mas_equalTo(self->doneNumLabel.mas_right).offset(0);
    }];
    
    
    
    priceLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"¥20.00" textColor:RGBA(237, 130, 32, 1) textAlignment:Left font:FONT(20)];
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(numBgView.mas_bottom).offset(SIZE(15));
        make.left.mas_equalTo(self->goodsImageView.mas_right).offset(SIZE(20));
    }];
    
    marketPriceLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"¥30.00" textColor:RGB153 textAlignment:Left font:FONT(12)];
    [self.contentView addSubview:marketPriceLabel];
    [marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self->priceLabel.mas_centerY).offset(0);
        make.left.mas_equalTo(self->priceLabel.mas_right).offset(SIZE(20));
    }];
    
}


-(void)setSpellGoodsModel:(CSSpellGoodsModel *)spellGoodsModel{
    _spellGoodsModel = spellGoodsModel;
    [goodsImageView sd_setImageWithURL:[NSURL URLWithString:_spellGoodsModel.goodsUrl] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    goodsNameLabel.text = isEmptyStr(_spellGoodsModel.goodsName)?@"":_spellGoodsModel.goodsName;
    NSString *locationStr = isEmptyStr(_spellGoodsModel.receiveAddress)?@"":[NSString stringWithFormat:@"%@  ",_spellGoodsModel.receiveAddress];
    NSString *sku = isEmptyStr(_spellGoodsModel.unit)?@"":_spellGoodsModel.unit;
    desLabel.text = [NSString stringWithFormat:@"%@%@",isEmptyStr(locationStr)?@"":locationStr,isEmptyStr(sku)?@"":sku];
    priceLabel.text = isEmptyStr(_spellGoodsModel.price)?@"":[NSString stringWithFormat:@"¥%@",_spellGoodsModel.price];
    
    NSString *marketPrice = isEmptyStr(_spellGoodsModel.rawPrice)?@"¥0.00":[NSString stringWithFormat:@"¥%@",_spellGoodsModel.rawPrice];
    NSDictionary *attribtDic2 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr2 = [[NSMutableAttributedString alloc]initWithString:marketPrice attributes:attribtDic2];
    marketPriceLabel.attributedText = attribtStr2;
    
    doneNumLabel.text = [NSString stringWithFormat:@"  已团%@份  ",_spellGoodsModel.thenGroup];
    leftNumLabel.text = [NSString stringWithFormat:@"  剩余%@份  ",_spellGoodsModel.inventory];
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
