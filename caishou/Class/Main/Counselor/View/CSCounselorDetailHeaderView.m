//
//  CSCounselorDetailHeaderView.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCounselorDetailHeaderView.h"
#import "HCSStarRatingView.h"
#import "IQKeyBoardManager.h"

@interface CSCounselorDetailHeaderView ()<UITextViewDelegate>
{
    UIImageView *_headerImageView;
    UILabel *_nameLabel;
    HCSStarRatingView *_HCSStarView;
    UILabel *_scoreLabel;
    UILabel *_memberNumberLabel;
    UILabel *_phoneLabel;
    UILabel *_idLabel;
    UILabel *_clubLabel;
    UITextView *_introTextView;
    UIButton *_editBtn;
}

@end

@implementation CSCounselorDetailHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    _headerImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self addSubview:_headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(15);
        make.width.height.mas_equalTo(75);
    }];
    _nameLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"孙文华" textColor:RGB(67, 207, 124) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Medium" size: 16]];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_headerImageView.mas_right).offset(30);
        make.top.mas_equalTo(self ->_headerImageView.mas_top);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(50);
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
        make.left.mas_equalTo(self ->_nameLabel.mas_right).offset(10);
        make.bottom.mas_equalTo(self -> _nameLabel.mas_bottom).offset(0);
        make.width.mas_equalTo(60);
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
    _memberNumberLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"会员：500人" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Regular" size: 14]];
    [self addSubview:_memberNumberLabel];
//   __block CGFloat width = [ZYQTool ZYQ_returnWidthAccordingText:_memberNumberLabel.text font:[UIFont fontWithName:@"PingFangSC-Regular" size: 14] height:21];
    [_memberNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_nameLabel.mas_left);
        make.top.mas_equalTo(self ->_nameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(21);
//        make.width.mas_equalTo(width);
    }];
    _phoneLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"手机：15666666666" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Regular" size: 14]];
    [self addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_nameLabel.mas_left);
        make.top.mas_equalTo(self ->_memberNumberLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(21);
        make.right.mas_equalTo(-10);
    }];
    
    _idLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"ID：222222" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Regular" size: 14]];
    _idLabel.hidden = YES;
    [self addSubview:_idLabel];
    [_idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_headerImageView.mas_left);
        make.top.mas_equalTo(self ->_headerImageView.mas_bottom).offset(5);
        make.height.mas_equalTo(21);
        make.right.mas_equalTo(self -> _nameLabel.mas_left);
    }];
    _clubLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"莱瘦俱乐部" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Regular" size: 14]];
    [self addSubview:_clubLabel];
    [_clubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_nameLabel.mas_left);
        make.top.mas_equalTo(self ->_idLabel.mas_top);
        make.height.mas_equalTo(21);
        make.right.mas_equalTo(-10);
    }];
    
    UILabel *introTitleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"个人简介" textColor:RGB(102, 102, 102) textAlignment:NSTextAlignmentLeft font:[UIFont fontWithName:@"PingFangSC-Regular" size: 14]];
    [self addSubview:introTitleLabel];
    [introTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self ->_idLabel.mas_left);
        make.top.mas_equalTo(self ->_idLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(65);
    }];
    _editBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) normalImage:@"edit" selectedImage:@"edit" touchUpInsideEvent:nil];
    [self addSubview:_editBtn];
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(introTitleLabel.mas_right).offset(5);
        make.top.mas_equalTo(introTitleLabel.mas_top).offset(5);
        make.width.height.offset(13);
    }];
    [_editBtn addTarget:self action:@selector(editIntroClick:) forControlEvents:UIControlEventTouchUpInside];
    _editBtn.hidden = true;
    
    
    _introTextView = [[UITextView alloc] init];
    _introTextView.toolbarPlaceholder = @"编辑简介";
    _introTextView.textColor = RGB(153, 153, 153);
    _introTextView.font = RegularFont(12);
    _introTextView.delegate = self;
//    [ViewCreate createTextFieldFrame:CGRectMake(0, 0, 0, 0) font:RegularFont(12) textColor:RGB(153, 153, 153) placeHolder:@"编辑简介" delegate:self];
    _introTextView.userInteractionEnabled = false;
    
    [self addSubview:_introTextView];
    [_introTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(introTitleLabel.mas_left).offset(10);
        make.top.mas_equalTo(introTitleLabel.mas_bottom).offset(15);
        make.bottom.offset(SIZE(-10));
        make.right.mas_equalTo(-10);
    }];
    [_introTextView addDoneOnKeyboardWithTarget:self action:@selector(btnDoneClick)];
}


-(void)setCounselorDetailModel:(CSCounselorDetailModel *)counselorDetailModel{
    _counselorDetailModel = counselorDetailModel;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:_counselorDetailModel.headImg] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    _nameLabel.text = isEmptyStr(_counselorDetailModel.name)?@"":_counselorDetailModel.name;
    _HCSStarView.value = isEmptyStr(_counselorDetailModel.score)?0:[_counselorDetailModel.score intValue];
    _scoreLabel.text = isEmptyStr(_counselorDetailModel.score)?@"":[NSString stringWithFormat:@"%@分",_counselorDetailModel.score];
    _memberNumberLabel.text = isEmptyStr(_counselorDetailModel.userNumber)?@"":[NSString stringWithFormat:@"会员：%@人",_counselorDetailModel.userNumber];
    _phoneLabel.text = isEmptyStr(_counselorDetailModel.mobile)?@"":[NSString stringWithFormat:@"手机：%@",_counselorDetailModel.mobile];
    _idLabel.text = isEmptyStr(_counselorDetailModel.ID)?@"":[NSString stringWithFormat:@"ID：%@",_counselorDetailModel.ID];
    _nameLabel.text = isEmptyStr(_counselorDetailModel.name)?@"":[NSString stringWithFormat:@"%@",_counselorDetailModel.name];
    _introTextView.text = isEmptyStr(_counselorDetailModel.introduce)?@"暂无简介":[NSString stringWithFormat:@"%@",_counselorDetailModel.introduce];
    _clubLabel.text = isEmptyStr(_counselorDetailModel.clubName)?@"暂无俱乐部":[NSString stringWithFormat:@"%@",_counselorDetailModel.clubName];;
    [self createTagFontLabel:[_counselorDetailModel.label componentsSeparatedByString:@","]];
}
#pragma mark - createTagLabel
- (void)createTagFontLabel:(NSArray *)arrs {
    __block CGFloat space = 10;
    for (int i = 0; i< arrs.count; i++) {
        UILabel *label = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(67, 207, 124) text:arrs[i] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter font:RegularFont(10)];
        [self addSubview:label];
        label.clipsToBounds = true;
        label.layer.cornerRadius = 5;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            CGFloat width = [ZYQTool ZYQ_returnWidthAccordingText:label.text font:RegularFont(10) height:21] + 10;
            make.left.mas_equalTo(self ->_memberNumberLabel.mas_right).offset(space);
            make.top.mas_equalTo(self ->_memberNumberLabel.mas_top);
            if (label.text.length == 1) {
                label.layer.cornerRadius = 21 * 0.5;
            }
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(width);
            space = space + width + 10;
        }];
    }
}
- (void)setEdit:(BOOL)edit {
    _edit = edit;
    if (edit) {
        _editBtn.hidden = false;
        
    }
}
- (void)editIntroClick:(UIButton *)sender {
    _introTextView.userInteractionEnabled = true;
    [_introTextView becomeFirstResponder];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
        if ([text isEqualToString:@"\n"]){  if (self.editIntroBlock) {
        self.editIntroBlock(_introTextView.text);
        }
        [_introTextView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (void)btnDoneClick {
    if (self.editIntroBlock) {
        self.editIntroBlock(_introTextView.text);
    }
    [_introTextView resignFirstResponder];
}
@end
