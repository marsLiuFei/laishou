//
//  CSSignDoneFlowCell.m
//  caishou
//
//  Created by 刘飞 on 2019/3/1.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSSignDoneFlowCell.h"

@implementation CSSignDoneFlowCell
{
    UIImageView *icon;
    UILabel *dayLabel;
    UIView *line;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = ClearColor;
        [self creatUI];
    }
    return self;
}
- (void )creatUI{
    icon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"signDone"];
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(SIZE(15));
        make.width.height.offset(SIZE(15));
    }];
    
    dayLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"03-01" textColor:RGBA(255, 250, 159, 1) textAlignment:Center font:RegularFont(10)];
    [self.contentView addSubview:dayLabel];
    [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->icon.mas_bottom).offset(SIZE(5));
        make.left.mas_equalTo(self->icon.mas_left).offset(0);
    }];
    
    line = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGBA(255, 250, 159, 1)];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self->icon.mas_centerY).offset(0);
        make.height.offset(SIZE(0.5));
        make.right.offset(0);
        make.left.mas_equalTo(self->icon.mas_right).offset(0);
    }];
}
-(void)setSignModel:(CSSignRecordsModel *)signModel{
    _signModel = signModel;
    dayLabel.text = isEmptyStr(_signModel.strTime)?@"":_signModel.strTime;
    icon.image = [UIImage imageNamed:_signModel.isSign?@"Sign_icon":@"unSign_icon"];
}


@end
