//
//  CSCounselorTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCounselorTableViewCell.h"
#import "HCSStarRatingView.h"
#import "ViewCreate.h"

@interface CSCounselorTableViewCell ()
{
    UIImageView *_leftImageView;
    UILabel *_titleLabel;
    HCSStarRatingView *_HCSStarView;
    UILabel *_scoreLabel;
    UILabel *_topLabel;
    UILabel *_phoneLabel;
    UILabel *_numberLabel;
    UILabel *_nameLabel;
}


@end
@implementation CSCounselorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self createrUI];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _leftImageView.clipsToBounds = true;
    _leftImageView.layer.cornerRadius =  (self.viewHeight - 20) * 0.5;
}
- (void)createrUI {
    _leftImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(self->_leftImageView.mas_height).offset(0);
    }];
    _topLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor redColor] text:@"1" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter font: [UIFont fontWithName:@"PingFangSC-Regular" size: 11]];
    _topLabel.clipsToBounds =true;
    _topLabel.layer.cornerRadius = 7;
    [self addSubview:_topLabel];
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_leftImageView.mas_right).offset(10);
        make.top.mas_equalTo(self -> _leftImageView.mas_top).offset(2);
        make.height.mas_equalTo(14);
        make.width.mas_greaterThanOrEqualTo(self -> _topLabel.mas_height);
    }];
    _titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"孙文华" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Medium" size: 14]];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_topLabel.mas_right).offset(5);
        make.top.mas_equalTo(self ->_leftImageView.mas_top);
        make.height.mas_equalTo(21);
        make.width.mas_lessThanOrEqualTo(self.mas_width).multipliedBy(0.6);
        
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
        make.left.mas_equalTo(self ->_topLabel.mas_left);
        make.top.mas_equalTo(self -> _titleLabel.mas_bottom).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    _scoreLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"4.7分" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Regular" size: 10]];
    [self addSubview:_scoreLabel];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_HCSStarView.mas_right).offset(5);
        make.top.mas_equalTo(self -> _HCSStarView.mas_top);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(self -> _HCSStarView.mas_height);
    }];
//    [self createTagLabel:@[@"1",@"2"]];
    _phoneLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"15666666666" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentRight font: [UIFont fontWithName:@"PingFangSC-Regular" size: 12]];
    [self addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//         CGFloat width = [ZYQTool ZYQ_returnWidthAccordingText:self -> _phoneLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size: 12] height:21];
        make.bottom.mas_equalTo(self ->_leftImageView.mas_bottom);
        make.left.mas_equalTo(self ->_topLabel.mas_left);
        make.height.mas_equalTo(21);
//        make.width.mas_equalTo(width);
    }];
    _numberLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"500学员" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentRight font: [UIFont fontWithName:@"PingFangSC-Regular" size: 12]];
    [self addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        CGFloat width = [ZYQTool ZYQ_returnWidthAccordingText:self -> _numberLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size: 12] height:21];
        make.top.mas_equalTo(self ->_phoneLabel.mas_top);
        make.left.mas_equalTo(self->_phoneLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(self ->_phoneLabel.mas_bottom);
//        make.width.mas_equalTo(width);
    }];
    _nameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"莱瘦俱乐部" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentRight font: [UIFont fontWithName:@"PingFangSC-Regular" size: 12]];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        CGFloat width = [ZYQTool ZYQ_returnWidthAccordingText:self -> _nameLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size: 12] height:21];
        make.top.mas_equalTo(self ->_numberLabel.mas_top);
        make.left.mas_equalTo(self ->_numberLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(self ->_numberLabel.mas_bottom);
//        make.width.mas_equalTo(width);
    }];
    
}

#pragma mark - createTagLabel
- (void)createTagLabel:(NSArray *)arrs {
    for (int i = 0; i< arrs.count; i++) {
        UILabel *label = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor greenColor] text:[NSString stringWithFormat:@"\u3000%@\u3000",arrs[i]] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Regular" size: 10]];
        [self addSubview:label];
        label.clipsToBounds = true;
        label.layer.cornerRadius = 6.5;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self -> _titleLabel.mas_right).offset(i * (32 + 5) +10);
            make.bottom.mas_equalTo(self ->_titleLabel.mas_bottom).offset(-5);
            make.height.mas_equalTo(13);
            make.width.mas_greaterThanOrEqualTo(label.mas_height);
//            make.width.mas_equalTo(32);
        }];
    }
}

/**
 *@pramas  counselorPageModel - 分页顾问model
 *@pramas index 排名
 */
- (void )setCounselorPageModel:(CSCounselorPageModel *)counselorPageModel index:(NSInteger )index{
    
    [self createTagLabel:[counselorPageModel.label componentsSeparatedByString:@","]];
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:counselorPageModel.headImg] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    _titleLabel.text = isEmptyStr(counselorPageModel.name)?@"":counselorPageModel.name;
    _HCSStarView.value = [counselorPageModel.score integerValue];
    _scoreLabel.text = isEmptyStr(counselorPageModel.score)?@"0分":[NSString stringWithFormat:@"%@分",counselorPageModel.score];
    _topLabel.text = [NSString stringWithFormat:@"%ld",index];
    if (index==1) {
        _topLabel.backgroundColor = RGBA(214, 0, 0, 1);
    }
    else if (index==2) {
        _topLabel.backgroundColor = RGBA(237, 130, 32, 1);
    }
    else  if (index==3) {
        _topLabel.backgroundColor = RGBA(67, 207, 124, 1);
    }
    else{
        _topLabel.backgroundColor = RGBA(153, 153, 153, 1);
    }
    _phoneLabel.text = isEmptyStr(counselorPageModel.mobile)?@"":counselorPageModel.mobile;
    _numberLabel.text = isEmptyStr(counselorPageModel.userNumber)?@"0学员":[NSString stringWithFormat:@"%@学员",counselorPageModel.userNumber];
    _nameLabel.text = isEmptyStr(counselorPageModel.clubName)?@"":counselorPageModel.clubName;
}


@end
