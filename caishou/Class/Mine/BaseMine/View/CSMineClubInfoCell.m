//
//  CSMineClubInfoCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSMineClubInfoCell.h"

@implementation CSMineClubInfoCell
{
    UILabel *clubNameLabel;
    UIButton *rankLabel;//排名
    UIImageView *clubImageView;//俱乐部头像
    UILabel *bindLabel;//是否绑定了顾问
    UIButton *applyBtn;//预约
    UIButton *bindCustomerBtn;//绑定顾问
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = WhiteColor;
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        [self creatUI];
    }
    return self;
}

- (void )creatUI{
    UILabel *la = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"俱乐部" textColor:BlackColor textAlignment:Left font:[UIFont boldSystemFontOfSize:SIZE(16)]];
    [self.contentView addSubview:la];
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.top.offset(SIZE(20));
    }];
    
    clubNameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"莱瘦俱乐部" textColor:MainColor textAlignment:Left font:FONT(12)];
    [self.contentView addSubview:clubNameLabel];
    [clubNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(la.mas_right).offset(SIZE(15));
        make.bottom.mas_equalTo(la.mas_bottom).offset(0);
    }];
    
    rankLabel = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"暂无排名 >" titleColor:RGB153 font:FONT(12) backgroundColor:ClearColor touchUpInsideEvent:nil];
    rankLabel.hidden = YES;
    [self.contentView addSubview:rankLabel];
    [rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.mas_equalTo(la.mas_bottom).offset(0);
        make.right.offset(-SIZE(15));
    }];
    
    clubImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"counselor"];
    clubImageView.layer.masksToBounds = YES;
    clubImageView.layer.cornerRadius = SIZE(25);
    [self.contentView addSubview:clubImageView];
    [clubImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.top.mas_equalTo(la.mas_bottom).offset(SIZE(20));
        make.width.height.offset(SIZE(50));
    }];
    
    
    bindLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"未绑定顾问" textColor:BlackColor textAlignment:Left font:[UIFont boldSystemFontOfSize:SIZE(16)]];
    [self.contentView addSubview:bindLabel];
    [bindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->clubImageView.mas_right).offset(SIZE(15));
        make.bottom.mas_equalTo(self->clubImageView.mas_centerY).offset(-SIZE(3));
    }];
    
    UILabel *desLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"同步成绩，咨询互动" textColor:RGBA(102, 102, 102, 1) textAlignment:Left font:FONT(12)];
    [self.contentView addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->clubImageView.mas_right).offset(SIZE(15));
        make.top.mas_equalTo(self->clubImageView.mas_centerY).offset(SIZE(3));
    }];
    
 
    bindCustomerBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"绑定" titleColor:RGB153 font:FONT(14) backgroundColor:ClearColor touchUpInsideEvent:nil];
    bindCustomerBtn.hidden = YES;
    bindCustomerBtn.layer.masksToBounds = YES;
    bindCustomerBtn.layer.cornerRadius = SIZE(12);
    bindCustomerBtn.layer.borderColor = RGB153.CGColor;
    bindCustomerBtn.layer.borderWidth = SIZE(0.5);
    [self.contentView addSubview:bindCustomerBtn];
    bindCustomerBtn.tag = 1200;
    [bindCustomerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bindCustomerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZE(15));
        make.centerY.mas_equalTo(self->clubImageView.mas_centerY).offset(0);
        make.height.offset(SIZE(24));
        make.width.offset(SIZE(80));
    }];
    
    
    applyBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"预约" titleColor:RGB153 font:FONT(14) backgroundColor:ClearColor touchUpInsideEvent:nil];
    applyBtn.tag = 1201;
    [applyBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    applyBtn.layer.masksToBounds = YES;
    applyBtn.layer.cornerRadius = SIZE(12);
    applyBtn.layer.borderColor = RGB153.CGColor;
    applyBtn.layer.borderWidth = SIZE(0.5);
    [self.contentView addSubview:applyBtn];
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->bindCustomerBtn.mas_left).offset(-SIZE(10));
        make.centerY.mas_equalTo(self->clubImageView.mas_centerY).offset(0);
        make.height.offset(SIZE(24));
        make.width.offset(SIZE(60));
    }];
    
}

-(void)setPersonalModel:(CSPersonalInfoModel *)personalModel{
    _personalModel = personalModel;
    clubNameLabel.text = isEmptyStr(_personalModel.clubName)?@"暂无俱乐部":_personalModel.clubName;
    bindLabel.text = isEmptyStr(_personalModel.counselorName)?@"未绑定顾问":_personalModel.counselorName;
    
    if ([_personalModel.counselorHeadImg hasPrefix:@"http"]) {
        [clubImageView sd_setImageWithURL:[NSURL URLWithString:_personalModel.counselorHeadImg] placeholderImage:[UIImage imageNamed:@"counselor"]];
    }else{
        clubImageView.image = [UIImage imageNamed:@"counselor"];
    }
    
    if (isEmptyStr(_personalModel.counselorName)) {
        bindCustomerBtn.hidden = NO;
        applyBtn.hidden = YES;
        [bindCustomerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-SIZE(15));
            make.centerY.mas_equalTo(self->clubImageView.mas_centerY).offset(0);
            make.height.offset(SIZE(24));
            make.width.offset(SIZE(80));
        }];
//        [applyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(self->bindCustomerBtn.mas_left).offset(-SIZE(10));
//            make.centerY.mas_equalTo(self->clubImageView.mas_centerY).offset(0);
//            make.height.offset(SIZE(24));
//            make.width.offset(SIZE(60));
//        }];
    }else{
        bindCustomerBtn.hidden = YES;
        applyBtn.hidden = NO;
        [applyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-SIZE(15));
            make.centerY.mas_equalTo(self->clubImageView.mas_centerY).offset(0);
            make.height.offset(SIZE(24));
            make.width.offset(SIZE(80));
        }];
    }
}



- (void )btnClick:(UIButton *)sender{
    if (self.clickBtnBlock) {
        self.clickBtnBlock(sender.tag-1200);
    }
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
