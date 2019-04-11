//
//  CSGoodsDetailInfoCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/27.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSGoodsDetailInfoCell.h"

@implementation CSGoodsDetailInfoCell
{
    UILabel *priceLabel;
    UILabel *marketPriceLabel;
    UILabel *joinCountLabel;
    UILabel *shareCountLabel;
    UILabel *goodsNameLabel;
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
    
    shareCountLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"已团1300份，剩61份" textColor:RGB153 textAlignment:Left font:RegularFont(12)];
    shareCountLabel.numberOfLines = 2;
    shareCountLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:shareCountLabel];
    [shareCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.top.offset(SIZE(5));
        make.height.offset(SIZE(20));
//        make.width.offset(SIZE(80));
//        make.right.offset(-SIZE(15));
//        make.top.mas_equalTo(self->priceLabel.mas_bottom).offset(SIZE(15));
    }];
    
    priceLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"¥9.9" textColor:RGBA(237, 130, 32, 1) textAlignment:Left font:MediumFont(22)];
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.top.mas_equalTo(self->shareCountLabel.mas_bottom).offset(0);
    }];
    
    marketPriceLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"¥10" textColor:RGB153 textAlignment:Left font:RegularFont(12)];
    [self.contentView addSubview:marketPriceLabel];
    [marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->priceLabel.mas_right).offset(SIZE(15));
        make.centerY.mas_equalTo(self->priceLabel.mas_centerY).offset(0);
    }];
    
    
    joinCountLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"已团1300份，剩61份" textColor:RGB153 textAlignment:Right font:RegularFont(12)];
    [self.contentView addSubview:joinCountLabel];
    [joinCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZE(15));
        make.bottom.mas_equalTo(self->priceLabel.mas_bottom).offset(0);
    }];
    
    
    
    
    goodsNameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"【新用户专享】黑茶牙膏酵素深层美白防蛀薄荷 牙膏 薄荷香型 （温和薄荷） 120g" textColor:RGB44 textAlignment:Left font:MediumFont(16)];
    goodsNameLabel.adjustsFontSizeToFitWidth = YES;
    goodsNameLabel.numberOfLines = 0;
    [self.contentView addSubview:goodsNameLabel];
    [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.right.offset(-SIZE(15));
        make.top.mas_equalTo(self->priceLabel.mas_bottom).offset(SIZE(15));
    }];
    
    
    
    
    
    UIView *line = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(234, 234, 234)];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.right.offset(-SIZE(15));
        make.bottom.offset(0);
        make.height.offset(SIZE(0.5));
    }];
}


-(void)setSpellGoodsModel:(CSSpellGoodsDetailModel *)spellGoodsModel{
    _spellGoodsModel = spellGoodsModel;
    priceLabel.text = isEmptyStr(_spellGoodsModel.price)?@"":[NSString stringWithFormat:@"¥%@",_spellGoodsModel.price];
    
    NSString *marketPrice = isEmptyStr(_spellGoodsModel.rawPrice)?@"¥0.00":[NSString stringWithFormat:@"¥%@",_spellGoodsModel.rawPrice];
    NSDictionary *attribtDic2 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr2 = [[NSMutableAttributedString alloc]initWithString:marketPrice attributes:attribtDic2];
    marketPriceLabel.attributedText = attribtStr2;
    joinCountLabel.text = [NSString stringWithFormat:@"已团%@份，剩%@份",isEmptyStr(_spellGoodsModel.thenGroup)?@"":_spellGoodsModel.thenGroup,isEmptyStr(_spellGoodsModel.inventory)?@"":_spellGoodsModel.inventory];
    
    shareCountLabel.text = [NSString stringWithFormat:@"浏览:%@次  分享:%@次",isEmptyStr(_spellGoodsModel.likeNumber)?@"":_spellGoodsModel.likeNumber,isEmptyStr(_spellGoodsModel.browseNumber)?@"":_spellGoodsModel.browseNumber];
    
    goodsNameLabel.text = isEmptyStr(_spellGoodsModel.goodsName)?@"":_spellGoodsModel.goodsName;
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
