//
//  CSSpecoalInterviewCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/23.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSSpecoalInterviewCell.h"

@implementation CSSpecoalInterviewCell
{
    UIImageView *icon;
    UILabel *titleLabel;
    UILabel *timeLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.contentView.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}
- (void )creatUI{
    icon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(SIZE(10));
        make.right.offset(-SIZE(10));
        make.height.offset(SIZE(100));
    }];
    
    timeLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"01:01" textColor:WhiteColor textAlignment:Right font:FONT(12)];
    timeLabel.hidden = YES;
    [icon addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.offset(-SIZE(5));
    }];
    
    titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"单例方法创建数据库, 如果使用shareDatabase创建" textColor:RGB44 textAlignment:Left font:[UIFont fontWithName:@"PingFangSC-Medium" size: SIZE(14)]];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(10));
        make.right.bottom.offset(-SIZE(10));
        make.top.mas_equalTo(self->icon.mas_bottom).offset(SIZE(10));
    }];
    
    
}
-(void)setActivityModel:(CSArticleListModel *)activityModel{
    _activityModel = activityModel;
    [icon sd_setImageWithURL:[NSURL URLWithString:_activityModel.img] placeholderImage:[UIImage imageNamed:@""]];
    titleLabel.text = isEmptyStr(_activityModel.articleTitle)?@"":_activityModel.articleTitle;
    
}
@end
