//
//  CSCounselorCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/24.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCounselorCell.h"
#import "HCSStarRatingView.h"
#import "ViewCreate.h"

@interface CSCounselorCell ()
{
    UIImageView *_leftImageView;
    UILabel *_titleLabel;
    HCSStarRatingView *_HCSStarView;
    UILabel *_scoreLabel;
    UILabel *_memberLabel;
    UILabel *_phoneLabel;
    UILabel *_numberLabel;
    UILabel *_nameLabel;
}

/** subArr */
@property(nonatomic , strong)NSMutableArray *subArr;
@end

@implementation CSCounselorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.subArr = [NSMutableArray array];
        [self createrUI];
    }
    return self;
}
- (void)createrUI {
    _leftImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    _leftImageView.clipsToBounds = true;
    _leftImageView.layer.cornerRadius = 10;
    [self addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(self->_leftImageView.mas_height).offset(0);
    }];
    _titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"莱瘦" textColor:RGB(53, 60, 54) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Medium" size: 15]];
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
    _memberLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"已有会员9527名" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Regular" size: 12]];
    [self addSubview:_memberLabel];
    [_memberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_titleLabel.mas_left);
        make.top.mas_equalTo(self -> _HCSStarView.mas_bottom).offset(5);
        make.height.mas_equalTo(21);
        make.width.mas_lessThanOrEqualTo(self.mas_width).multipliedBy(0.6);
    }];
    _phoneLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"15666666666" textColor:RGB(152, 153, 152) textAlignment:NSTextAlignmentRight font:[UIFont fontWithName:@"PingFangSC-Regular" size: 10]];
    [self addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self ->_memberLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self ->_titleLabel.mas_left);
        make.height.mas_equalTo(21);
    }];
    UIView *line1 = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(153, 153, 153)];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self ->_phoneLabel.mas_top).offset(6);
        make.left.mas_equalTo(self ->_phoneLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(self ->_phoneLabel.mas_bottom).offset(-6);
        make.width.mas_equalTo(1);
    }];
    _numberLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"500学员" textColor:RGB(153, 153, 153) textAlignment:NSTextAlignmentRight font:[UIFont fontWithName:@"PingFangSC-Regular" size: 10]];
    [self addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self ->_phoneLabel.mas_top);
        make.left.mas_equalTo(line1.mas_right).offset(5);
        make.bottom.mas_equalTo(self ->_phoneLabel.mas_bottom);
    }];
    UIView *line2 = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(153, 153, 153)];
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self ->_numberLabel.mas_top).offset(6);
        make.left.mas_equalTo(self ->_numberLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(self ->_numberLabel.mas_bottom).offset(-6);
        make.width.mas_equalTo(1);
    }];
    _nameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"莱瘦俱乐部" textColor:RGB(153, 153, 153) textAlignment:NSTextAlignmentRight font:[UIFont fontWithName:@"PingFangSC-Regular" size: 10]];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self ->_numberLabel.mas_top);
        make.left.mas_equalTo(line2.mas_right).offset(5);
        make.bottom.mas_equalTo(self ->_numberLabel.mas_bottom);
    }];
    
}

#pragma mark - createTagLabel
- (void)createTagLabel:(NSArray *)arrs {
    for (int i = 0; i< arrs.count; i++) {
        UILabel *label = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"会员多多" textColor:RGB(140, 178, 61) textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:15]];
        [self addSubview:label];
        label.clipsToBounds = true;
        label.layer.cornerRadius = 5;
        label.layer.borderColor = RGB(140, 178, 61).CGColor;
        label.layer.borderWidth = 1;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self -> _titleLabel.mas_left).offset(i * (75 + 10));
            make.top.mas_equalTo(self ->_memberLabel.mas_bottom);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(75);
        }];
    }
}

- (void)createTagFontLabel:(NSArray *)arrs {
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


-(void)setCounselorListModel:(CSCounselorListModel *)counselorListModel{
    _counselorListModel = counselorListModel;
    for (UILabel *label in self.subArr) {
        [label removeFromSuperview];
    }
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_counselorListModel.headImg] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    _titleLabel.text = isEmptyStr(_counselorListModel.name)?@"":_counselorListModel.name;
    _HCSStarView.value = [_counselorListModel.score integerValue];
    _scoreLabel.text = isEmptyStr(_counselorListModel.score)?@"0分":[NSString stringWithFormat:@"%@分",_counselorListModel.score];
    _memberLabel.text = isEmptyStr(_counselorListModel.userNumber)?@"":[NSString stringWithFormat:@"已有会员%@名",_counselorListModel.userNumber];
    _phoneLabel.text = isEmptyStr(_counselorListModel.mobile)?@"":_counselorListModel.mobile;
    _numberLabel.text = isEmptyStr(_counselorListModel.userNumber)?@"0学员":[NSString stringWithFormat:@"%@学员",_counselorListModel.userNumber];
    _nameLabel.text = isEmptyStr(_counselorListModel.clubName)?@"":_counselorListModel.clubName;
    [self createTagFontLabel:[_counselorListModel.label componentsSeparatedByString:@","]];
}


@end
