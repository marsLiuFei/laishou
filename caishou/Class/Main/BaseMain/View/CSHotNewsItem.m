//
//  CSHotNewsItem.m
//  caishou
//
//  Created by 刘飞 on 2019/3/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSHotNewsItem.h"

@implementation CSHotNewsItem
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
#pragma mark - setupUI
- (void)setupUI {
    _imageView = [ViewCreate createImageViewFrame:CGRectMake(0, 0, 0, 0) image:@"popup_img"];
    [self.contentView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(self.contentView.mas_height).multipliedBy(0.6);
    }];
    _titleLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:[UIColor clearColor] text:@"莱瘦俱乐部" textColor:BlackColor textAlignment:NSTextAlignmentLeft font:RegularFont(15)];
    _titleLabel.numberOfLines = 2;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self ->_imageView.mas_bottom).offset(0);
        make.bottom.offset(0);
        make.left.offset(SIZE(5));
        make.right.offset(SIZE(-5));
    }];
}
- (void)setArticleModel:(CSArticleListModel *)articleModel {
    _articleModel = articleModel;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:articleModel.img] placeholderImage:[UIImage imageNamed:@"popup_img"]];
    _titleLabel.text = articleModel.articleTitle;
}



@end
