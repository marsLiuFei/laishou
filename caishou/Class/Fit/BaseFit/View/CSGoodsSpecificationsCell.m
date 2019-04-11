//
//  CSGoodsSpecificationsCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/28.
//  Copyright © 2019年 mars. All rights reserved.
//  规格

#import "CSGoodsSpecificationsCell.h"

@implementation CSGoodsSpecificationsCell
{
    UILabel *specificationsLabel;//规格
    UITextField *numTf;//数量
    UIButton *addBtn;//加
    UIButton *subtractBtn;//减
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
    UILabel *la = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"规格" textColor:RGB44 textAlignment:Left font:MediumFont(16)];
    [self.contentView addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(SIZE(15));
    }];
    
    specificationsLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"2斤/份 0.2" textColor:RGB153 textAlignment:Left font:RegularFont(14)];
    [self.contentView addSubview:specificationsLabel];
    [specificationsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.top.mas_equalTo(la.mas_bottom).offset(SIZE(15));
    }];
    
    
    addBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) normalImage:@"add" selectedImage:@"add" touchUpInsideEvent:nil];
    [self.contentView addSubview:addBtn];
    addBtn.tag = 10010;
    [addBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZE(15));
        make.centerY.offset(0);
        make.width.height.offset(SIZE(30));
    }];
    
    
    numTf = [ViewCreate createTextFieldFrame:CGRectMake(0, 0, 0, 0) font:MediumFont(20) textColor:RGB44 placeHolder:@"0" delegate:nil];
    numTf.userInteractionEnabled = NO;
    numTf.keyboardType = UIKeyboardTypeNumberPad;
    numTf.textAlignment = NSTextAlignmentCenter;
    numTf.backgroundColor = RGBA(238, 238, 238, 1);
    [self.contentView addSubview:numTf];
    [numTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->addBtn.mas_left).offset(0);
        make.height.offset(SIZE(30));
        make.centerY.offset(0);
//        make.width.mas_greaterThanOrEqualTo(SIZE(30));
        make.width.offset(SIZE(60));
    }];
    
    
    subtractBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) normalImage:@"subtract" selectedImage:@"subtract" touchUpInsideEvent:nil];
    subtractBtn.tag = 10011;
    [subtractBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:subtractBtn];
    [subtractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->numTf.mas_left).offset(0);
        make.centerY.offset(0);
        make.width.height.offset(SIZE(30));
    }];
    
}

- (void )clickBtn:(UIButton *)sender{
    if (self.addOrCutBtnClickBlock) {
        self.addOrCutBtnClickBlock((sender.tag==10010)?YES:NO, numTf.text);
    }
    
    
//    switch (sender.tag) {
//        case 10010:
//            //加
//        {
//            numTf.text = [NSString stringWithFormat:@"%ld",[numTf.text integerValue]+1];
//        }
//            break;
//        case 10011:
//            //减
//        {
//            if ([numTf.text integerValue]>0) {
//                numTf.text = [NSString stringWithFormat:@"%ld",[numTf.text integerValue]-1];
//            }
//        }
//            break;
//
//        default:
//            break;
//    }
//    self.spellModel.goodsCount = numTf.text;
}

-(void)setSpellModel:(CSSpellGoodsDetailModel *)spellModel{
    _spellModel = spellModel;
    specificationsLabel.text = isEmptyStr(_spellModel.unit)?@"":_spellModel.unit;
    numTf.text = isEmptyStr(_spellModel.goodsCount)?@"0":_spellModel.goodsCount;
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
