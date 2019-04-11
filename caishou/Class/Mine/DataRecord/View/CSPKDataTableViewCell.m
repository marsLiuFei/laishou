//
//  CSPKDataTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSPKDataTableViewCell.h"

@interface CSPKDataTableViewCell ()
{
    UIImageView *_myImageView;
    UIImageView *_friendImageView;
    UILabel *_myNameLabel;
    UILabel *_friendNameLabel;
    UILabel *_bottomLabel;
    UIView *_headView;
}
/** viewArray */
@property(nonatomic , strong)NSMutableArray *viewArray;


@end

@implementation CSPKDataTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.viewArray = [NSMutableArray array];
        [self setupUI];
        
    }
    return self;
}
- (void)setupUI {
    UIView *lineView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(67, 207, 124)];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.top.offset(SIZE(15));
        make.width.offset(SIZE(2));
        make.height.offset(SIZE(15));
    }];
    UILabel *pkLabel  = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"好友PK" textColor:RGB(53, 60, 54) textAlignment:NSTextAlignmentLeft font:MediumFont(16)];
    [self.contentView addSubview:pkLabel];
    [pkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_top).offset(SIZE(-4));
        make.left.mas_equalTo(lineView.mas_right).offset(5);
        make.height.offset(SIZE(21));
        make.width.offset(SCREEN_WIDTH *0.33);
    }];
    UIButton *pkBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"找好友PK" titleColor:RGB(67, 207, 124) font:RegularFont(12) backgroundColor:[UIColor whiteColor] touchUpInsideEvent:nil];
    [pkBtn setImage:[UIImage imageNamed:@"change"] forState:UIControlStateNormal];
    [pkBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    pkBtn.layer.borderWidth = 1;
    pkBtn.layer.borderColor = RGB(67, 207, 124).CGColor;
    pkBtn.clipsToBounds = true;
    pkBtn.layer.cornerRadius = SIZE(25) *0.5;
    [pkBtn addTarget:self action:@selector(pkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:pkBtn];
    [pkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(SIZE(-10));
        make.top.mas_equalTo(lineView.mas_top).offset(SIZE(-4));
        make.width.offset(SIZE(80));
        make.height.offset(SIZE(25));
    }];
    UIView *headView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor];
    [self.contentView addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(pkLabel.mas_bottom).offset(5);
        make.height.offset(SIZE(108));
    }];
    _headView = headView;
    [self createHeadeView:headView];
    [self createBttomView:headView infoModel:nil];
    
}
- (void)createHeadeView:(UIView *)superView {
    _myImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"counselor"];
    [superView addSubview:_myImageView];
    _myImageView.clipsToBounds = true;
    _myImageView.layer.cornerRadius = SIZE(88) * 0.5;
    [_myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.width.height.mas_equalTo(SIZE(88));
        make.centerX.mas_equalTo(self.mas_centerX).offset(SIZE(-65));
    }];
    _myNameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor blackColor] text:@"我" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:RegularFont(10)];
    _myNameLabel.alpha = 0.5;
    [_myImageView addSubview:_myNameLabel];
    [_myNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.offset(SIZE(24));
    }];
    UIImageView *pkImage = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"pk"];
    [superView addSubview:pkImage];
    [pkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SIZE(35));
        make.width.height.mas_equalTo(SIZE(58));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    _friendImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"counselor"];
    [superView addSubview:_friendImageView];
    _friendImageView.clipsToBounds = true;
    _friendImageView.layer.cornerRadius = SIZE(88) * 0.5;
    [_friendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.width.height.mas_equalTo(SIZE(88));
        make.centerX.mas_equalTo(self.mas_centerX).offset(SIZE(65));
    }];
    _friendNameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor blackColor] text:@"张三" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:RegularFont(10)];
    _friendNameLabel.alpha = 0.5;
    [_friendImageView addSubview:_friendNameLabel];
    [_friendNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.offset(SIZE(24));
    }];
}

- (UIView *)rowListView:(NSString *)title leftName:(NSString *)leftName leftRatio:(CGFloat)leftRatio rigthName:(NSString *)rightName rightRatio:(CGFloat)rightRatio {
    UIView *superView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(38))];
    UILabel *titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor whiteColor] text:title textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentCenter font:RegularFont(12)];
    [superView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(SIZE(21));
    }];
    UILabel *leftLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor whiteColor] text:leftName textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentCenter font:RegularFont(12)];
    [superView addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.top.mas_equalTo(titleLabel.mas_bottom);
        make.left.offset(SIZE(11));
    }];
    UILabel *rightLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor whiteColor] text:rightName textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentCenter font:RegularFont(12)];
    [superView addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.top.mas_equalTo(titleLabel.mas_bottom);
        make.right.offset(SIZE(-11));
    }];
    UIView *longView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(238, 238, 238)];
    [superView addSubview:longView];
    longView.clipsToBounds = true;
    longView.layer.cornerRadius = SIZE(3) * 0.5;
    [longView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(SIZE(-6));
        make.height.mas_equalTo(SIZE(3));
        make.left.mas_equalTo(leftLabel.mas_right).offset(5);
        make.right.mas_equalTo(rightLabel.mas_left).offset(-5);
    }];
    UIView *leftView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(67, 207, 124)];
    [longView addSubview:leftView];
    leftView.clipsToBounds = true;
    leftView.layer.cornerRadius = SIZE(3) * 0.5;
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.mas_equalTo(superView.mas_width).multipliedBy(0.5 * leftRatio);
        make.right.mas_equalTo(superView).multipliedBy(0.5);
    }];
    UIView *rightView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(170, 170, 107)];
    [longView addSubview:rightView];
    rightView.clipsToBounds = true;
    rightView.layer.cornerRadius = SIZE(3) * 0.5;
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.mas_equalTo(superView.mas_width).multipliedBy(0.5 * rightRatio);
        make.left.mas_equalTo(leftView.mas_right);
    }];
    
    
    return superView;
}
- (void)createBttomView:(UIView *)headView  infoModel:(CSPKInfoModel *)pkInfoModel{
    
    CGFloat leftRatio = [pkInfoModel.myPk.weight doubleValue]/150.0;
    CGFloat rightRatio = [pkInfoModel.otherPk.weight doubleValue]/150.0;
    UIView *firstView = [self rowListView:@"体重"
                                 leftName:pkInfoModel ==nil?@"150kg":[NSString stringWithFormat:@"%@kg",pkInfoModel.myPk.weight]
                                leftRatio:leftRatio
                                rigthName:pkInfoModel ==nil?@"150kg":[NSString stringWithFormat:@"%@kg",pkInfoModel.otherPk.weight]
                               rightRatio:rightRatio];
    [self.contentView addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(headView.mas_bottom).offset(0);
        make.height.offset(SIZE(38));
    }];
    leftRatio = [pkInfoModel.myPk.bmi doubleValue]/100.0;
    rightRatio = [pkInfoModel.otherPk.bmi doubleValue]/100.0;
    UIView *secondView = [self rowListView:@"BMI"
                                  leftName:pkInfoModel ==nil?@"37.5":[NSString stringWithFormat:@"%@",pkInfoModel.myPk.bmi]
                                 leftRatio:leftRatio
                                 rigthName:pkInfoModel ==nil?@"65.5":[NSString stringWithFormat:@"%@",pkInfoModel.otherPk.bmi]
                                rightRatio:rightRatio];
    [self.contentView addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(firstView.mas_bottom).offset(0);
        make.height.offset(SIZE(38));
    }];
    
    leftRatio = [pkInfoModel.myPk.fatRate doubleValue]/100.0;
    rightRatio = [pkInfoModel.otherPk.fatRate doubleValue]/100.0;
    UIView *threeView = [self rowListView:@"体脂率"
                                 leftName:pkInfoModel ==nil?@"65.2%":[NSString stringWithFormat:@"%.2lf%%",[pkInfoModel.myPk.fatRate floatValue]]
                                leftRatio:leftRatio
                                rigthName:pkInfoModel ==nil?@"70%":[NSString stringWithFormat:@"%.2lf%%",[pkInfoModel.myPk.fatRate floatValue]]
                               rightRatio:rightRatio];
    
    [self.contentView addSubview:threeView];
    [threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(secondView.mas_bottom).offset(0);
        make.height.offset(SIZE(38));
    }];
    leftRatio = [pkInfoModel.myPk.age doubleValue]/100.0;
    rightRatio = [pkInfoModel.otherPk.age doubleValue]/100.0;
    UIView *fourView = [self rowListView:@"身体年龄"
                                leftName:pkInfoModel ==nil?@"37岁":[NSString stringWithFormat:@"%@",pkInfoModel.myPk.age]
                               leftRatio:leftRatio
                               rigthName:pkInfoModel ==nil?@"40岁":[NSString stringWithFormat:@"%@",pkInfoModel.otherPk.age]
                              rightRatio:rightRatio];
    [self.contentView addSubview:fourView];
    [fourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(threeView.mas_bottom).offset(0);
        make.height.offset(SIZE(38));
    }];
    _bottomLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"恭喜您！" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentCenter font:RegularFont(16)];
    [self.contentView addSubview:_bottomLabel];
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.top.mas_equalTo(fourView.mas_bottom);
    }];
    [self.viewArray addObjectsFromArray:@[firstView,secondView,threeView,fourView]];
}

#pragma mark - click
- (void)pkBtnClick:(UIButton *)sender {
    if (self.PKClickBlock) {
        self.PKClickBlock();
    }
}

-(void)setPkInfoModel:(CSPKInfoModel *)pkInfoModel {
    _pkInfoModel = pkInfoModel;
    [_myImageView sd_setImageWithURL:[NSURL URLWithString:pkInfoModel.myPk.headImg] placeholderImage:[UIImage imageNamed:@"counselor"]];
     [_friendImageView sd_setImageWithURL:[NSURL URLWithString:pkInfoModel.otherPk.headImg] placeholderImage:[UIImage imageNamed:@"counselor"]];
    for (UIView *view in self.viewArray) {
        [view removeFromSuperview];
    }
    [self createBttomView:_headView infoModel:pkInfoModel];
}
@end
