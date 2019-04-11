//
//  CSMineCommonlyCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSMineCommonlyCell.h"

@implementation CSMineCommonlyCell
{
    UIImageView *icon;
    UILabel *titleLabel;
    UILabel *contentLabel;
    UIImageView *accessIcon;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

- (void )creatUI{
    icon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@""];
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.centerY.offset(0);
        make.height.width.offset(SIZE(22));
    }];
    titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB44 textAlignment:Left font:FONT(16)];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->icon.mas_right).offset(SIZE(10));
        make.centerY.offset(0);
        
    }];
    
    accessIcon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"arrow_right"];
    [self.contentView addSubview:accessIcon];
    [accessIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZE(15));
        make.centerY.offset(0);
        make.height.width.offset(SIZE(12));
    }];
    contentLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB(127,127,127) textAlignment:Left font:FONT(14)];
    [self.contentView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->accessIcon.mas_left).offset(-SIZE(5));
        make.centerY.offset(0);
    }];
    
    self.selectedBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) normalBackgroundImage:@"unselectedIntegrel" selectedBackgroundImage:@"selectedIntegrel" touchUpInsideEvent:nil];
    self.selectedBtn.hidden = YES;
    [self.selectedBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectedBtn];
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(SIZE(20));
        make.centerY.offset(0);
        make.right.mas_equalTo(self->contentLabel.mas_left).offset(-SIZE(4));
    }];
    
    
    UIView *bottomLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(236, 236, 236)];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(SIZE(0.5));
    }];
}
-(void)setContent:(NSString *)content{
    _content = content;
    contentLabel.text = _content;
}
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    icon.image = [UIImage imageNamed:_imageName];
}
-(void)setTitleName:(NSString *)titleName{
    _titleName = titleName;
    titleLabel.text = _titleName;
}
-(void)setHiddenRightImage:(BOOL)hiddenRightImage{
    _hiddenRightImage = hiddenRightImage;
    accessIcon.hidden = _hiddenRightImage;
    [contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZE(15));
        make.centerY.offset(0);
    }];
}

-(void)setIsSetTitleNameLabelLeft:(BOOL)isSetTitleNameLabelLeft{
    _isSetTitleNameLabelLeft = isSetTitleNameLabelLeft;
    titleLabel.textAlignment  = _isSetTitleNameLabelLeft?NSTextAlignmentLeft:NSTextAlignmentCenter;
    icon.hidden = YES;
    [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.centerY.offset(0);
    }];
}


- (void )clickBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.selectedIntegralBlock) {
        self.selectedIntegralBlock();
    }
}

-(void)setIsShowSelectedBtn:(BOOL)isShowSelectedBtn{
    _isShowSelectedBtn = isShowSelectedBtn;
    self.selectedBtn.hidden = !_isShowSelectedBtn;
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
