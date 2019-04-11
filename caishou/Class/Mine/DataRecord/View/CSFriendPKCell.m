//
//  CSFriendPKCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSFriendPKCell.h"

@interface CSFriendPKCell ()
{
    UIImageView *_headerImageView;
    UILabel *_titlelabel;
    UIButton *_pkBtn;
}

@end

@implementation CSFriendPKCell

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
    self.clipsToBounds = true;
    self.layer.cornerRadius = 5;
    _headerImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"counselor"];
    [self.contentView addSubview:_headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(SIZE(13));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(SIZE(50));
    }];
    _titlelabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"姓名" textColor:RGB(53, 60, 54) textAlignment:Left font:MediumFont(14)];
    [self.contentView addSubview:_titlelabel];
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self -> _headerImageView.mas_right).offset(SIZE(20));
        make.width.offset(SIZE(100));
        make.top.bottom.offset(0);
    }];
    _pkBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"PK" titleColor:RGB(67, 207, 124) font:MediumFont(12) backgroundColor:[UIColor whiteColor] touchUpInsideEvent:nil];
    _pkBtn.layer.borderWidth = 1;
    _pkBtn.layer.borderColor = RGB(67, 207, 124).CGColor;
    _pkBtn.clipsToBounds = true;
    _pkBtn.layer.cornerRadius = SIZE(25) *0.5;
    [self.contentView addSubview:_pkBtn];
    [_pkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(SIZE(-10));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.offset(SIZE(80));
        make.height.offset(SIZE(25));
    }];
    
    
}
- (void)setFrame:(CGRect)frame{
    frame.origin.x += 15;
    frame.origin.y += 8;
    frame.size.height -= 8;
    frame.size.width -= 30;
    [super setFrame:frame];
}


@end
