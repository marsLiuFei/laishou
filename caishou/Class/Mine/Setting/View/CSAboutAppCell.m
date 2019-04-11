//
//  CSAboutAppCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/14.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSAboutAppCell.h"

@interface CSAboutAppCell ()


@end

@implementation CSAboutAppCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
    }
    return self;
}

- (void )creatUI{
    _titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:WhiteColor text:@"" textColor:RGB44 textAlignment:Left font:FONT(16)];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(16));
        make.centerY.offset(0);
        
    }];
    UIImageView *accessIcon = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"arrow_right"];
    [self.contentView addSubview:accessIcon];
    [accessIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-SIZE(15));
        make.centerY.offset(0);
        make.height.width.offset(SIZE(12));
    }];
    UIView *bottomLine = [ViewCreate createLineFrame:CGRectMake(0, 0, 0, 0) backgroundColor:RGB(236, 236, 236)];
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(SIZE(0.5));
    }];
}

@end
