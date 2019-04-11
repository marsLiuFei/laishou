//
//  CSActivityDetailInfoCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSActivityDetailInfoCell.h"

@implementation CSActivityDetailInfoCell
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
        make.height.width.offset(SIZE(15));
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
        make.left.mas_equalTo(self->icon.mas_right).offset(SIZE(10));
        make.centerY.offset(0);
    }];
    
}



- (void )setIconWithName:(NSString *)iconName content:(NSString *)content isHiddenRightIcon:(BOOL )hidden{
    accessIcon.hidden = hidden;
    contentLabel.text = content;
    icon.image = [UIImage imageNamed:iconName];
}

-(void)setRightIcon:(NSString *)rightIcon{
    _rightIcon = rightIcon;
    accessIcon.hidden = NO;
    accessIcon.image = [UIImage imageNamed:_rightIcon];
}


-(void)setContentColor:(UIColor *)contentColor{
    _contentColor = contentColor;
    contentLabel.textColor = _contentColor;
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
