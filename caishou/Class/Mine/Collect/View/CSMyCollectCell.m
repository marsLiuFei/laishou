//
//  CSMyCollectCell.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/9.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSMyCollectCell.h"

@implementation CSMyCollectCell
{
    UIImageView *icon;
    UILabel *titleLabel;
    UILabel *contentsLabel;
    UIButton *collectBtn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}
- (void )creatUI{
    icon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(SIZE(5));
        make.right.offset(-SIZE(5));
        make.height.mas_equalTo(self->icon.mas_width);
    }];
    
    collectBtn = [ViewCreate createButtonFrame:CGRectMake(0, SIZE(15), SIZE(60), SIZE(20)) title:@"20" titleColor:[UIColor whiteColor] font:RegularFont(SIZE(10)) backgroundColor:RGBA(237, 130, 32, 1) touchUpInsideEvent:nil];
    [self.contentView addSubview:collectBtn];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: collectBtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(SIZE(10),SIZE(10))];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = collectBtn.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    collectBtn.layer.mask = maskLayer;
    
    [collectBtn setImage:[UIImage imageNamed:@"collect_icon"] forState:UIControlStateNormal];
    [collectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    
    titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"过完年后怎样才能轻松甩掉赘肉？" textColor:RGB44 textAlignment:Left font:MediumFont(12)];
    titleLabel.numberOfLines = 2;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(SIZE(35));
        make.left.offset(SIZE(5));
        make.right.offset(-SIZE(5));
        make.top.mas_equalTo(self->icon.mas_bottom).offset(SIZE(5));
    }];
    
    contentsLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"过完年后怎样才能轻松甩掉赘肉？过完年后怎样才能轻松甩掉赘肉？" textColor:RGB153 textAlignment:Left font:RegularFont(10)];
    contentsLabel.numberOfLines = 2;
    [self.contentView addSubview:contentsLabel];
    [contentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(SIZE(35));
        make.left.offset(SIZE(5));
        make.right.offset(-SIZE(5));
        make.top.mas_equalTo(self->titleLabel.mas_bottom).offset(SIZE(5));
    }];
}

-(void)setCollectModel:(CSMyCollectModel *)collectModel{
    _collectModel = collectModel;
    [icon sd_setImageWithURL:[NSURL URLWithString:_collectModel.img] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    if ([_collectModel.collectNumber isEqualToString:@"0"] ||
        isEmptyStr(_collectModel.collectNumber)) {
        collectBtn.hidden = true;
    }else {
       [collectBtn setTitle:_collectModel.collectNumber forState:UIControlStateNormal];
    }
   
    titleLabel.text = isEmptyStr(_collectModel.articleTitle)?@"":_collectModel.articleTitle;
    contentsLabel.text = isEmptyStr(_collectModel.simple)?@"":_collectModel.simple;
}

@end
