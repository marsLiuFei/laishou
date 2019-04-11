//
//  CSMyInfoHeaderView.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/4.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSMyInfoHeaderView.h"

@implementation CSMyInfoHeaderView
{
    UIImageView *_headerImageView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    UIImageView *bgImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    UIImageView *headerImageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"counselor"];
    [self addSubview:headerImageView];
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageClick:)];
    [headerImageView addGestureRecognizer:tapG];
    headerImageView.clipsToBounds = true;
    headerImageView.userInteractionEnabled = true;
    headerImageView.layer.cornerRadius = SIZE(75)  *0.5;
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.viewY + 10);
        make.width.height.mas_offset(SIZE(75));
    }];
    _headerImageView = headerImageView;
    
}
- (void)headImageClick:(UITapGestureRecognizer *)tapG {
    if (self.headerImageClick) {
        self.headerImageClick();
    }
}
- (void)setupHeaderImage:(UIImage *)image {
    _headerImageView.image = image;
}
- (void)setImageStr:(NSString *)imageStr {
    _imageStr = imageStr;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:self.imageStr] placeholderImage:[UIImage imageNamed:@"counselor"]];
}
@end
