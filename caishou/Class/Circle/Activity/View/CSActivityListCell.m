//
//  CSActivityListCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/23.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSActivityListCell.h"

@implementation CSActivityListCell
{
    UIImageView *icon;
    UILabel *titleLabel;
    UILabel *statusLabel;
    UILabel *locationLabel;
    UILabel *priceLabel;
    UILabel *joinCountLabel;
    
    //莱瘦圈活动详情展示
    UILabel *contentsLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}


- (void )creatUI{
    icon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.centerY.offset(0);
        make.width.offset(SIZE(160));
        make.height.offset(SIZE(100));
    }];
    
    titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"正月里～闹元宵，阿斯顿发送到发送到发送地方" textColor:RGBA(53, 60, 54, 1) textAlignment:Left font:[UIFont fontWithName:@"PingFangSC-Medium" size: SIZE(14)]];
    titleLabel.numberOfLines = 2;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SIZE(10));
        make.left.mas_equalTo(self->icon.mas_right).offset(SIZE(5));
        make.right.offset(-SIZE(15));
        make.height.mas_lessThanOrEqualTo(SIZE(40));
    }];
    
    
    
    contentsLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB153 textAlignment:Left font:FONT(12)];
    contentsLabel.numberOfLines = 0;
    contentsLabel.hidden = YES;
    [self.contentView addSubview:contentsLabel];
    [contentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->titleLabel.mas_bottom).offset(SIZE(5));
        make.left.mas_equalTo(self->icon.mas_right).offset(SIZE(5));
        make.right.offset(-SIZE(15));
        make.height.mas_lessThanOrEqualTo(SIZE(40));
    }];
    
    
    
    statusLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"已结束" textColor:RGB153 textAlignment:Center font:FONT(10)];
    [self.contentView addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->icon.mas_right).offset(SIZE(5));
        make.top.mas_equalTo(self->titleLabel.mas_bottom).offset(SIZE(5));
    }];
    
    locationLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"蜀山区" textColor:RGB153 textAlignment:Center font:FONT(10)];
    [self.contentView addSubview:locationLabel];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->statusLabel.mas_right).offset(SIZE(5));
        make.top.mas_equalTo(self->titleLabel.mas_bottom).offset(SIZE(5));
        make.right.offset(-SIZE(15));
    }];
    
    
    priceLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"免费" textColor:RGB(255,162,0) textAlignment:Center font:FONT(10)];
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->icon.mas_right).offset(SIZE(5));
        make.bottom.mas_equalTo(self->icon.mas_bottom).offset(0);
    }];
    
    
    joinCountLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGBA(255,153,0,0.3) text:@"\u3000仅剩9名额\u3000" textColor:RGB(255,153,0) textAlignment:Left font:FONT(12)];
    joinCountLabel.hidden = YES;
    joinCountLabel.layer.borderColor = RGB(255,153,0).CGColor;
    joinCountLabel.layer.borderWidth = SIZE(0.5);
    joinCountLabel.layer.cornerRadius = SIZE(3);
    [self.contentView addSubview:joinCountLabel];
    [joinCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZE(15));
        make.height.offset(SIZE(20));
        make.bottom.mas_equalTo(self->icon.mas_bottom).offset(0);
    }];
    
}
-(void)setActivityModel:(CSActivityListModel *)activityModel{
    _activityModel = activityModel;
    [icon sd_setImageWithURL:[NSURL URLWithString:_activityModel.img] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    titleLabel.text = isEmptyStr(_activityModel.activityTitle)?@"":[NSString stringWithFormat:@"%@",_activityModel.activityTitle];
    
//    活动状态（1:未开始;2:进行中;3:已结束）
    if ([_activityModel.appActivityStatus isEqualToString:@"1"]) {
        statusLabel.text = @"未开始";
    }
    else if ([_activityModel.appActivityStatus isEqualToString:@"2"]){
        statusLabel.text = @"进行中";
    }
    else{
        statusLabel.text = @"已结束";
    }
    
    locationLabel.text = isEmptyStr(_activityModel.clubAddress)?@"":[NSString stringWithFormat:@"%@",_activityModel.clubAddress];
    if ([_activityModel.signType isEqualToString:@"1"]) {
        //钱
        if ([[NSString stringWithFormat:@"%@",_activityModel.price] isEqualToString:@"0"]) {
            priceLabel.text = @"免费";
        }else{
            priceLabel.text = isEmptyStr(_activityModel.price)?@"":[NSString stringWithFormat:@"¥%@",_activityModel.price];
        }
        
    }
    else if ([_activityModel.signType isEqualToString:@"2"]) {
        //积分
        if ([[NSString stringWithFormat:@"%@",_activityModel.price] isEqualToString:@"0"]) {
            priceLabel.text = @"免费";
        }else{
            priceLabel.text = isEmptyStr(_activityModel.price)?@"":[NSString stringWithFormat:@"%@积分",_activityModel.price];
        }
        
    }
    if ([_activityModel.signNumber isEqualToString:@"0"]) {
        joinCountLabel.text = @" 人数已满 ";
        joinCountLabel.textColor = RGB153;
        joinCountLabel.backgroundColor = RGB(234, 234, 234);
        joinCountLabel.layer.borderColor = RGB153.CGColor;
    }else{
        joinCountLabel.text = isEmptyStr(_activityModel.signNumber)?@"":[NSString stringWithFormat:@" 仅剩%@名额 ",_activityModel.signNumber];
        joinCountLabel.backgroundColor = RGBA(255,153,0,0.3);
        joinCountLabel.textColor = RGB(255,153,0);
        joinCountLabel.layer.borderColor = RGB(255,153,0).CGColor;
    }
    
}



-(void)setArticleListModel:(CSArticleListModel *)articleListModel{
    _articleListModel = articleListModel;
    
    joinCountLabel.hidden = YES;
    priceLabel.hidden = YES;
    statusLabel.hidden = YES;
    locationLabel.hidden = YES;
    
    [icon sd_setImageWithURL:[NSURL URLWithString:_articleListModel.img] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    titleLabel.text = isEmptyStr(_articleListModel.articleTitle)?@"":[NSString stringWithFormat:@"%@",_articleListModel.articleTitle];
    
    contentsLabel.hidden = NO;
    contentsLabel.text = isEmptyStr(_articleListModel.simple)?@"":[NSString stringWithFormat:@"%@",_articleListModel.simple];
    
    
    
//    //    活动状态（1:未开始;2:进行中;3:已结束）
//    if ([_articleListModel.status isEqualToString:@""]) {
//        statusLabel.text = @"未开始";
//    }
//    else if ([_articleListModel.status isEqualToString:@""]){
//        statusLabel.text = @"进行中";
//    }
//    else{
//        statusLabel.text = @"已结束";
//    }
    
//    locationLabel.text = isEmptyStr(_activityModel.clubAddress)?@"":[NSString stringWithFormat:@"%@",_activityModel.clubAddress];
//    if ([_articleListModel.articleType isEqualToString:@"1"]) {
//        //钱
//        if ([[NSString stringWithFormat:@"%@",_articleListModel.price] isEqualToString:@"0"]) {
//            priceLabel.text = @"免费";
//        }else{
//            priceLabel.text = isEmptyStr(_activityModel.price)?@"":[NSString stringWithFormat:@"¥%@",_activityModel.price];
//        }
//
//    }
//    else if ([_activityModel.signType isEqualToString:@"2"]) {
//        //积分
//        if ([[NSString stringWithFormat:@"%@",_activityModel.price] isEqualToString:@"0"]) {
//            priceLabel.text = @"免费";
//        }else{
//            priceLabel.text = isEmptyStr(_activityModel.price)?@"":[NSString stringWithFormat:@"%@积分",_activityModel.price];
//        }
//
//    }
//    if ([_activityModel.signNumber isEqualToString:@"0"]) {
//        joinCountLabel.text = @" 人数已满 ";
//        joinCountLabel.textColor = RGB153;
//        joinCountLabel.backgroundColor = RGB(234, 234, 234);
//        joinCountLabel.layer.borderColor = RGB153.CGColor;
//    }else{
//        joinCountLabel.text = isEmptyStr(_activityModel.signNumber)?@"":[NSString stringWithFormat:@" 仅剩%@名额 ",_activityModel.signNumber];
//        joinCountLabel.backgroundColor = RGBA(255,153,0,0.3);
//        joinCountLabel.textColor = RGB(255,153,0);
//        joinCountLabel.layer.borderColor = RGB(255,153,0).CGColor;
//    }
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
