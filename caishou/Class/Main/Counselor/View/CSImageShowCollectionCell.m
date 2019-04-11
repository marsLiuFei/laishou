//
//  CSImageShowCollectionCell.m
//  caishou
//
//  Created by 刘飞 on 2019/3/21.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSImageShowCollectionCell.h"

@implementation CSImageShowCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = WhiteColor;
        self.icon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
        [self.contentView addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(SIZE(10));
            make.right.bottom.offset(-SIZE(10));
        }];
    }
    return self;
}

-(void)setMenberModel:(CSCounselorMienListModel *)menberModel{
    _menberModel = menberModel;
    if ([_menberModel.picture hasPrefix:@"http"]) {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:_menberModel.picture] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    }else{
        self.icon.image = [UIImage imageNamed:_menberModel.picture];
    }
}


@end
