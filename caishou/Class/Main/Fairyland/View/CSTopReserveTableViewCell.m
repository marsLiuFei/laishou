//
//  CSTopReserveTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/1.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSTopReserveTableViewCell.h"
#import "HCSStarRatingView.h"

@interface CSTopReserveTableViewCell ()
{
    UIImageView *_topImageView;
    UIImageView *_leftImageView;
    UILabel *_titleLabel;
    HCSStarRatingView *_HCSStarView;
    UILabel *_scoreLabel;
    UILabel *_phoneLabel;
    UILabel *_numberLabel;
    UILabel *_nameLabel;
}
/** subArr */
@property(nonatomic , strong)NSMutableArray *subArr;
@end



@implementation CSTopReserveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
              self.subArr = [NSMutableArray array];
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
    
    _topImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"one"];
    [self addSubview:_topImageView];
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(22);
        make.bottom.mas_equalTo(-22);
        make.width.mas_equalTo(self->_topImageView.mas_height).multipliedBy(0.7);
    }];
    _leftImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_topImageView.mas_right).offset(20);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(self->_leftImageView.mas_height).offset(0);
    }];
    _titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"孙文华" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Medium" size: 14]];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_leftImageView.mas_right).offset(10);
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
        make.left.mas_equalTo(self ->_titleLabel.mas_left);
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
    [self createTagLabel:@[@"1",@"2"]];
    _phoneLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"15666666666" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font: [UIFont fontWithName:@"PingFangSC-Regular" size: 12]];
    [self addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self ->_leftImageView.mas_bottom);
        make.left.mas_equalTo(self ->_titleLabel.mas_left);
        make.height.mas_equalTo(21);
    }];
    _numberLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"500学员" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font: [UIFont fontWithName:@"PingFangSC-Regular" size: 12]];
    [self addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self ->_phoneLabel.mas_top);
        make.left.mas_equalTo(self->_phoneLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(self ->_phoneLabel.mas_bottom);
    }];
    _nameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"莱瘦俱乐部" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font: [UIFont fontWithName:@"PingFangSC-Regular" size: 12]];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self ->_numberLabel.mas_top);
        make.left.mas_equalTo(self ->_numberLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(self ->_numberLabel.mas_bottom);
    }];
    UIView *lineView = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(238, 238, 238)];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-1);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - createTagLabel
- (void)createTagLabel:(NSArray *)arrs {
    __block CGFloat space = 10;
    for (int i = 0; i< arrs.count; i++) {
        UILabel *label = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(67, 207, 124) text:arrs[i] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter font:RegularFont(10)];
        [self addSubview:label];
        label.clipsToBounds = true;
        label.layer.cornerRadius = 5;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat width = [ZYQTool ZYQ_returnWidthAccordingText:label.text font:RegularFont(10) height:21] + 10;
            make.left.mas_equalTo(self ->_titleLabel.mas_right).offset(space);
            make.top.mas_equalTo(self ->_leftImageView.mas_top);
            if (label.text.length == 1) {
                label.layer.cornerRadius = 21 * 0.5;
            }
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(width);
            space = space + width + 10;
        }];
        [self.subArr addObject:label];
    }
}
- (void)setCounselorModel:(CSCounselorPageModel *)counselorModel {
    _counselorModel = counselorModel;
    for (UILabel *label in self.subArr) {
        [label removeFromSuperview];
    }
    [self createTagLabel:[counselorModel.label componentsSeparatedByString:@","]];
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:counselorModel.headImg] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    _titleLabel.text = isEmptyStr(counselorModel.name)?@"":counselorModel.name;
    _HCSStarView.value = [counselorModel.score integerValue];
    _scoreLabel.text = isEmptyStr(counselorModel.score)?@"0分":[NSString stringWithFormat:@"%@分",counselorModel.score];
    if (_index==0) {
        _topImageView.image = [UIImage imageNamed:@"one"];
    }
    else if (_index==1) {
        _topImageView.image = [UIImage imageNamed:@"two"];
    }
    else  {
         _topImageView.image = [UIImage imageNamed:@"three"];
    }
    _phoneLabel.text = isEmptyStr(counselorModel.mobile)?@"":counselorModel.mobile;
    _numberLabel.text = isEmptyStr(counselorModel.userNumber)?@"0学员":[NSString stringWithFormat:@"%@学员",counselorModel.userNumber];
    _nameLabel.text = isEmptyStr(_clubStr)?@"":_clubStr;
    
    
}


@end
