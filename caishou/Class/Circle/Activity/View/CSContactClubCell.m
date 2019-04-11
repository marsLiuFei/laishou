//
//  CSContactClubCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSContactClubCell.h"

@implementation CSContactClubCell
{
    UIImageView *clubIcon;//俱乐部图片
    UILabel *clubNameLabel;
    UILabel *countLabel;
    UILabel *desLabel;
    UIButton *shareBtn;
    UIButton *contactBtn;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
//        [self creatUI];
        
        desLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB102 textAlignment:Left font:RegularFont(17)];
        desLabel.numberOfLines = 0;
        [self.contentView addSubview:desLabel];
        [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(SIZE(15));
            make.right.bottom.offset(-SIZE(15));
        }];
        
    }
    return self;
}

-(void)setContents:(NSString *)contents{
    _contents = contents;
    desLabel.text = isEmptyStr(_contents)?@"":_contents;
}

//- (void )creatUI{
//    clubIcon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"counselor"];
//    clubIcon.layer.masksToBounds = YES;
//    clubIcon.layer.cornerRadius = SIZE(40);
//    [self.contentView addSubview:clubIcon];
//    [clubIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.offset(SIZE(15));
//        make.width.height.offset(SIZE(80));
//    }];
//
//    clubNameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"莱瘦俱乐部" textColor:BlackColor textAlignment:Left font:[UIFont boldSystemFontOfSize:SIZE(15)]];
//    [self.contentView addSubview:clubNameLabel];
//    [clubNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self->clubIcon.mas_centerY).offset(-SIZE(5));
//        make.left.mas_equalTo(self->clubIcon.mas_right).offset(SIZE(10));
//    }];
//
//    countLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"32 活动 | 2790 粉丝" textColor:RGB(102, 102, 102) textAlignment:Left font:FONT(12)];
//    [self.contentView addSubview:countLabel];
//    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self->clubIcon.mas_centerY).offset(SIZE(5));
//        make.left.mas_equalTo(self->clubIcon.mas_right).offset(SIZE(10));
//    }];
//
//    desLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"Ta组织活动太忙，还没腾出空写简介" textColor:RGB(102, 102, 102) textAlignment:Left font:FONT(12)];
//    desLabel.numberOfLines = 0;
//    [self.contentView addSubview:desLabel];
//    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(SIZE(15));
//        make.right.offset(-SIZE(15));
//        make.top.mas_equalTo(self->clubIcon.mas_bottom).offset(SIZE(10));
//
//    }];
//
//    shareBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"分享" titleColor:WhiteColor font:FONT(16) backgroundColor:MainColor touchUpInsideEvent:nil];
//    shareBtn.layer.masksToBounds = YES;
//    shareBtn.layer.cornerRadius = SIZE(5);
//    [self.contentView addSubview:shareBtn];
//    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(SIZE(15));
//        make.top.mas_equalTo(self->desLabel.mas_bottom).offset(SIZE(10));
//        make.height.offset(SIZE(35));
//    }];
//
//    contactBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@" 联系Ta" titleColor:MainColor font:FONT(16) backgroundColor:RGB(238, 238, 238) touchUpInsideEvent:nil];
//    [contactBtn setImage:[UIImage imageNamed:@"circle_msg"] forState:UIControlStateNormal];
//    [contactBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -contactBtn.titleLabel.bounds.size.width)];
//    contactBtn.layer.masksToBounds = YES;
//    contactBtn.layer.cornerRadius = SIZE(5);
//    [self.contentView addSubview:contactBtn];
//    [contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(-SIZE(15));
//        make.top.mas_equalTo(self->desLabel.mas_bottom).offset(SIZE(10));
//        make.height.offset(SIZE(35));
//        make.left.mas_equalTo(self->shareBtn.mas_right).offset(SIZE(20));
//        make.width.mas_equalTo(self->shareBtn.mas_width);
//    }];
//
//
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
