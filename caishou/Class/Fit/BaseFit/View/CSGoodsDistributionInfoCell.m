//
//  CSGoodsDistributionInfoCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSGoodsDistributionInfoCell.h"

@implementation CSGoodsDistributionInfoCell
{
    UIButton *distributionTimeBtn;//次日达
    UIButton *locationBtn;//产地
    
    UIButton *ziyingBtn;//自营
    UIButton *zhixiaoBtn;//直销
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
    distributionTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [distributionTimeBtn setTitle:@"次日达" forState:UIControlStateNormal];
    [distributionTimeBtn setTitleColor:RGB(102,102,102) forState:UIControlStateNormal];
    distributionTimeBtn.titleLabel.font = RegularFont(12);
    [distributionTimeBtn setImage:[UIImage imageNamed:@"benifitGoods_icon01"] forState:UIControlStateNormal];
    [distributionTimeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.contentView addSubview:distributionTimeBtn];
    [distributionTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.height.offset(SIZE(20));
        make.centerY.offset(0);
    }];
    
    locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationBtn setTitle:@"源自合肥" forState:UIControlStateNormal];
    [locationBtn setTitleColor:RGB(102,102,102) forState:UIControlStateNormal];
    locationBtn.titleLabel.font = RegularFont(12);
    [locationBtn setImage:[UIImage imageNamed:@"benifitGoods_icon02"] forState:UIControlStateNormal];
    [locationBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.contentView addSubview:locationBtn];
    [locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->distributionTimeBtn.mas_right).offset(SIZE(20));
        make.height.offset(SIZE(20));
        make.centerY.offset(0);
        make.width.mas_equalTo(self->distributionTimeBtn.mas_width);
    }];
    
    ziyingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ziyingBtn setTitle:@"自营商品" forState:UIControlStateNormal];
    [ziyingBtn setTitleColor:RGB(102,102,102) forState:UIControlStateNormal];
    ziyingBtn.titleLabel.font = RegularFont(12);
    [ziyingBtn setImage:[UIImage imageNamed:@"benifitGoods_icon03"] forState:UIControlStateNormal];
    [ziyingBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12)];
    [self.contentView addSubview:ziyingBtn];
    [ziyingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->locationBtn.mas_right).offset(SIZE(20));
        make.height.offset(SIZE(20));
        make.centerY.offset(0);
        make.width.mas_equalTo(self->locationBtn.mas_width);
    }];
    
    zhixiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhixiaoBtn setTitle:@"直采直销" forState:UIControlStateNormal];
    [zhixiaoBtn setTitleColor:RGB(102,102,102) forState:UIControlStateNormal];
    zhixiaoBtn.titleLabel.font = RegularFont(12);
    [zhixiaoBtn setImage:[UIImage imageNamed:@"benifitGoods_icon04"] forState:UIControlStateNormal];
    [zhixiaoBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.contentView addSubview:zhixiaoBtn];
    [zhixiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->ziyingBtn.mas_right).offset(SIZE(20));
        make.height.offset(SIZE(20));
        make.right.offset(-SIZE(15));
        make.centerY.offset(0);
        make.width.mas_equalTo(self->ziyingBtn.mas_width);
    }];
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
