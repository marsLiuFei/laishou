//
//  CSClubCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/21.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSClubCell.h"
#import "HCSStarRatingView.h"
#import "ViewCreate.h"

@interface CSClubCell ()
{
    UIImageView *_leftImageView;
    UILabel *_titleLabel;
    HCSStarRatingView *_HCSStarView;
    UILabel *_scoreLabel;
    UILabel *_memberLabel;
    UILabel *_distanceLabel;
    UILabel *_siteLabel;
}
/** subArr */
@property(nonatomic , strong)NSMutableArray *subArr;


@end

@implementation CSClubCell

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
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(self->_leftImageView.mas_height).offset(0);
    }];
    _titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"莱瘦俱乐部" textColor:RGB(53, 60, 54) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Medium" size: 15]];
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
    _HCSStarView.value = 0;
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
        make.top.mas_equalTo(self -> _HCSStarView.mas_bottom);
        make.height.mas_equalTo(21);
        make.width.mas_lessThanOrEqualTo(self.mas_width).multipliedBy(0.6);
    }];
    
    _siteLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"<500m" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentRight font:[UIFont fontWithName:@"PingFangSC-Regular" size: 11]];
    [self addSubview:_siteLabel];
    [_siteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(100);
    }];
    _distanceLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"政务区万达写字楼" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentRight font:[UIFont fontWithName:@"PingFangSC-Regular" size: 11]];
    [self addSubview:_distanceLabel];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self ->_siteLabel.mas_top);
        make.right.mas_equalTo(self ->_siteLabel.mas_right);
        make.height.mas_equalTo(21);
        make.width.mas_lessThanOrEqualTo(self.mas_width).multipliedBy(0.35);
    }];
    
    
}

#pragma mark - createTagLabel
- (void)createTagLabel:(NSArray *)arrs {
    for (int i = 0; i< arrs.count; i++) {
        UILabel *label = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:arrs[i] textColor:RGB(128, 181, 26) textAlignment:NSTextAlignmentCenter font:RegularFont(10)];
        [self addSubview:label];
        label.clipsToBounds = true;
        label.layer.cornerRadius = 5;
        label.layer.borderColor = RGB(128, 181, 26).CGColor;
        label.layer.borderWidth = 1;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self -> _titleLabel.mas_left).offset(i * (55 + 5));
            make.top.mas_equalTo(self ->_memberLabel.mas_bottom);
            make.height.mas_equalTo(17);
            make.width.mas_greaterThanOrEqualTo(label.mas_height);
//            make.width.mas_equalTo(55);
        }];
        [self.subArr addObject:label];
    }
}

- (void)createTagFontLabel:(NSArray *)arrs {
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arrs.count];
    //1:活;2:惠;3:团;4:火
    for (int i=0; i<arrs.count; i++) {
        if ([[NSString stringWithFormat:@"%@",arrs[i]] isEqualToString:@"1"]) {
            [arrM addObject:@{@"name":@"活",@"color":RGB(124, 202, 225)}];
        }
        else if ([[NSString stringWithFormat:@"%@",arrs[i]] isEqualToString:@"2"]) {
            [arrM  insertObject:@{@"name":@"惠",@"color":RGB(137, 201, 151)} atIndex:0];
        }
        else if ([[NSString stringWithFormat:@"%@",arrs[i]] isEqualToString:@"3"]) {
            [arrM insertObject:@{@"name":@"团",@"color":RGB(75, 177, 225)} atIndex:0];
        }
        else if ([[NSString stringWithFormat:@"%@",arrs[i]] isEqualToString:@"4"]) {
            [arrM insertObject:@{@"name":@"火",@"color":RGB(254, 93, 93)} atIndex:0];
        }
    }
    for (int i = 0; i< arrM.count; i++) {
        NSDictionary *dic = arrM[i];
        UILabel *label = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:dic[@"color"] text:dic[@"name"] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter font:RegularFont(10)];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-(i * (15 + 5) + 10));
            make.top.mas_equalTo(self ->_leftImageView.mas_top);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(15);
        }];
        [self.subArr addObject:label];
    }
}


-(void)setClubModel:(CSClubListModel *)clubModel{
    _clubModel = clubModel;
    for (UILabel *label in self.subArr) {
        [label removeFromSuperview];
    }
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_clubModel.logo] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    _titleLabel.text = isEmptyStr(_clubModel.clubName)?@"":_clubModel.clubName;
    _HCSStarView.value = [_clubModel.score integerValue];
    _scoreLabel.text = isEmptyStr(_clubModel.score)?@"0分":[NSString stringWithFormat:@"%@分",_clubModel.score];
    _memberLabel.text = isEmptyStr(_clubModel.userNumber)?@"":[NSString stringWithFormat:@"已有会员%@名",_clubModel.userNumber];
    _distanceLabel.text = isEmptyStr(_clubModel.clubAddress)?@"":_clubModel.clubAddress;
    _siteLabel.text = isEmptyStr(_clubModel.nearInfo)?@"":_clubModel.nearInfo;
    
    [self createTagLabel:[_clubModel.label componentsSeparatedByString:@","]];
    NSArray *arr = [_clubModel.iconType componentsSeparatedByString:@","];
    [self createTagFontLabel:arr];
}

@end
