//
//  CSChoosePayModeCell.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/17.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSChoosePayModeCell.h"

@implementation CSChoosePayModeCell
{
    UIImageView *icon;
    UILabel *titleLabel;
    UILabel *desLabel;
    UIButton *selectedBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}
- (void )creatUI{
    icon = [UIImageView new];
    [self.contentView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(15));
        make.centerY.offset(0);
        make.width.height.offset(SIZE(27));
    }];

    titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB44 textAlignment:Left font:MediumFont(14)];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self->icon.mas_centerY).offset(-SIZE(3));
        make.left.mas_equalTo(self->icon.mas_right).offset(SIZE(10));
    }];

    desLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"" textColor:RGB102 textAlignment:Left font:RegularFont(12)];
    [self.contentView addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->icon.mas_centerY).offset(SIZE(3));
        make.left.mas_equalTo(self->icon.mas_right).offset(SIZE(10));
    }];

    selectedBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) normalImage:@"unselected_icon" selectedImage:@"selected_icon" touchUpInsideEvent:nil];
    selectedBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:selectedBtn];
    [selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZE(15));
        make.centerY.offset(0);
    }];
}
-(void)setPayMode:(CSChoosePayModeModel *)payMode{
    _payMode = payMode;
    icon.image = [UIImage imageNamed:_payMode.iconName];
    titleLabel.text = _payMode.name;
    desLabel.text = _payMode.des;
    selectedBtn.selected = _payMode.isSelected;
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
