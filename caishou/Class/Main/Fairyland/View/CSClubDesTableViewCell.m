//
//  CSClubDesTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSClubDesTableViewCell.h"
#import "HCSStarRatingView.h"

@interface CSClubDesTableViewCell ()
{
    UILabel *_titleLabel;
    HCSStarRatingView *_HCSStarView;
    UILabel *_scoreLabel;
    UILabel *_businesslabel;
    UILabel *_locationLabel;
    UILabel *_locNumberLabel;
}

@end

@implementation CSClubDesTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}


#pragma mark - setupUI
- (void)setupUI {
    _titleLabel =  [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"莱瘦俱乐部" textColor:RGB(67, 207, 124) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Medium" size: 17]];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(17);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(21);
    }];
    _HCSStarView  = [HCSStarRatingView new];
    _HCSStarView.userInteractionEnabled = false;
    _HCSStarView.maximumValue = 5;
    _HCSStarView.minimumValue = 0;
    _HCSStarView.value = 4;
    _HCSStarView.tintColor = RGB(250, 219, 79);
    _HCSStarView.allowsHalfStars = YES;
    _HCSStarView.spacing = 5;
    _HCSStarView.shouldBecomeFirstResponder = false;
    [self addSubview:_HCSStarView];
    [_HCSStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_titleLabel.mas_left);
        make.top.mas_equalTo(self -> _titleLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(18);
    }];
    _scoreLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"4.7分" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Regular" size: 10]];
    [self addSubview:_scoreLabel];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_HCSStarView.mas_right).offset(5);
        make.top.mas_equalTo(self -> _HCSStarView.mas_top);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(self -> _HCSStarView.mas_height);
    }];
    UIView *lineView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(238, 238, 238)];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self -> _titleLabel.mas_left);
        make.right.mas_equalTo(self -> _titleLabel.mas_right);
        make.top.mas_equalTo(self ->_HCSStarView.mas_bottom).offset(5);
        make.height.mas_equalTo(1);
    }];
    UIView *businView = [self createBusinessView];
    [businView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self -> _titleLabel.mas_left);
        make.right.mas_equalTo(self -> _titleLabel.mas_right);
        make.top.mas_equalTo(lineView.mas_bottom);
        make.height.mas_equalTo(33);
    }];
    UIView *line2View = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(238, 238, 238)];
    [self addSubview:line2View];
    [line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self -> _titleLabel.mas_left);
        make.right.mas_equalTo(self -> _titleLabel.mas_right);
        make.top.mas_equalTo(businView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    UIView *locView = [self createLocationView];
    [locView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self -> _titleLabel.mas_left);
        make.right.mas_equalTo(self -> _titleLabel.mas_right);
        make.top.mas_equalTo(line2View.mas_bottom);
        make.height.mas_equalTo(51);
    }];
    UIView *line3View = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(238, 238, 238)];
    [self addSubview:line3View];
    [line3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self -> _titleLabel.mas_left);
        make.right.mas_equalTo(self -> _titleLabel.mas_right);
        make.top.mas_equalTo(locView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    UIView *bottomView = [self createBottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self -> _titleLabel.mas_left);
        make.right.mas_equalTo(self -> _titleLabel.mas_right);
        make.top.mas_equalTo(line3View.mas_bottom);
        make.height.mas_equalTo(37);
    }];
    
}

- (UIView *)createBusinessView {
    UIView *bussView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor whiteColor]];
    [self addSubview:bussView];
    UILabel *rightLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@">" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentRight font:[UIFont fontWithName:@"PingFangSC-Regular" size: 14]];
    [bussView addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(20);
    }];
    _businesslabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"营业至22:00" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Regular" size: 14]];
    [bussView addSubview:_businesslabel];
    [_businesslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(rightLabel.mas_left).offset(-5);
    }];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(businessBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bussView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    return bussView;
}
- (UIView *)createLocationView{
    UIView *locView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor whiteColor]];
    [self addSubview:locView];
    UIImageView *leftImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"location_icon"];
    [locView addSubview:leftImageView];
    leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(15);
    }];
   
    _locationLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"安徽省合肥市蜀山去湖光路1181号附近" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Medium" size: 14]];
    [locView addSubview:_locationLabel];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImageView.mas_right).offset(5);
        make.right.offset(-5);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(42);
    }];
//    _locNumberLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"距?m" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Regular" size: 11]];
//    _locNumberLabel.hidden = YES;
//    [locView addSubview:_locNumberLabel];
//    [_locNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self ->_locationLabel.mas_left);
//        make.bottom.mas_equalTo(0);
//        make.top.mas_equalTo(self ->_locationLabel.mas_bottom);
//        make.right.mas_equalTo(self ->_locationLabel.mas_right);
//    }];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [locView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(self ->_locationLabel.mas_right);
    }];
    return locView;
}
- (UIView *)createBottomView{
    UIView *bottomView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor whiteColor]];
    [self addSubview:bottomView];
    UIImageView *leftImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"reserve"];
    [bottomView addSubview:leftImageView];
    leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(leftImageView.mas_height);
    }];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [bottomView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(rightBtn.mas_height);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    UILabel *reserveTitle = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"立即预订" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Medium" size: 14]];
    [bottomView addSubview:reserveTitle];
    [reserveTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImageView.mas_right).offset(5);
        make.right.mas_equalTo(rightBtn.mas_left).offset(-5);
        make.top.bottom.mas_equalTo(0);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(reserveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(rightBtn.mas_left).offset(0);
    }];
    return bottomView;
}

-(void)setClubDetailModel:(CSClubDetailInfoModel *)clubDetailModel{
    _clubDetailModel = clubDetailModel;
    _titleLabel.text = isEmptyStr(clubDetailModel.clubName)?@"":clubDetailModel.clubName;
    _HCSStarView.value = isEmptyStr(clubDetailModel.score)?0:[clubDetailModel.score intValue];
    _scoreLabel.text = isEmptyStr(clubDetailModel.score)?@"":[NSString stringWithFormat:@"%@分",isEmptyStr(clubDetailModel.score)?@"0":@([clubDetailModel.score intValue])];
    
    _locationLabel.text = isEmptyStr(clubDetailModel.clubAddress)?@"":clubDetailModel.clubAddress;
    _businesslabel.text = isEmptyStr(clubDetailModel.businessTime)?@"营业至":[NSString stringWithFormat:@"营业至%@" , clubDetailModel.businessTime];
    
    
}



#pragma mark - click
- (void)businessBtnClick:(UIButton *)sender {
    NSLog(@"营业时间按钮点击");
}
- (void)callPhone:(UIButton *)sender {
    NSLog(@"打电话按钮点击");
    UIWebView * callWebview = [[UIWebView alloc]init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.clubDetailModel.clubPhone]]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
}
- (void)locationBtnClick:(UIButton *)sender {
    NSLog(@"地址定位按钮点击");
    if (self.goAreaBlock) {
        self.goAreaBlock(self.clubDetailModel.lat, self.clubDetailModel.lng);
    }
}
- (void)reserveBtnClick:(UIButton *)sender {
    NSLog(@"订购按钮点击");
}

@end
