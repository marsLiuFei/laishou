//
//  CSAdvertisingCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/21.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSAdvertisingCell.h"
#import "CSBannerModel.h"

@interface CSAdvertisingCell ()
{
    UIImageView *_bigImageView;
    UIImageView *_leftImageView;
    UIImageView *_rightImageView;
}

@end

@implementation CSAdvertisingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
        
    }
    return self;
}
#pragma mark - setupUI
- (void)setupUI {
    _bigImageView = [self createImageViewBound:false cornerRadius:15];
    [_bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.5);
    }];
    _bigImageView.userInteractionEnabled = YES;
    _bigImageView.tag = 1000;
    [_bigImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)]];
    
    _leftImageView = [self createImageViewBound:false cornerRadius:0];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self->_bigImageView.mas_bottom).offset(0);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
    }];
    _leftImageView.userInteractionEnabled = YES;
    _leftImageView.tag = 1001;
    [_leftImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)]];
    _rightImageView = [self createImageViewBound:false cornerRadius:0];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(0);
        make.left.mas_equalTo(self->_leftImageView.mas_right).offset(0);
        make.top.mas_equalTo(self->_bigImageView.mas_bottom).offset(0);
    }];
    _rightImageView.userInteractionEnabled = YES;
    _rightImageView.tag = 1002;
    [_rightImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)]];
    _bigImageView.backgroundColor = [UIColor yellowColor];
    _leftImageView.backgroundColor = [UIColor grayColor];
    _rightImageView.backgroundColor = [UIColor greenColor];
     _bigImageView.image = [UIImage imageNamed:@"popup_img"];
     _leftImageView.image = [UIImage imageNamed:@"popup_img"];
     _rightImageView.image = [UIImage imageNamed:@"popup_img"];
    
    
}

- (void )clickImage:(UITapGestureRecognizer *)tap{
    
    
    
    if (tap.view.tag==1000) {
        NSString *jumpUrl = nil;
        for (CSBannerModel *bannerModel in _activityImages) {
            if ([bannerModel.advType isEqualToString:@"2"]) {
                jumpUrl = bannerModel.url;
            }
        }
        
        if (self.jumpBannerDetailBlock) {
            self.jumpBannerDetailBlock(jumpUrl);
        }
    }
    else if (tap.view.tag==1000) {
        NSString *jumpUrl = nil;
        for (CSBannerModel *bannerModel in _activityImages) {
            if ([bannerModel.advType isEqualToString:@"3"]) {
                jumpUrl = bannerModel.url;
            }
        }
        
        if (self.jumpBannerDetailBlock) {
            self.jumpBannerDetailBlock(jumpUrl);
        }
    }
    else{
        NSString *jumpUrl = nil;
        for (CSBannerModel *bannerModel in _activityImages) {
            if ([bannerModel.advType isEqualToString:@"4"]) {
                jumpUrl = bannerModel.url;
            }
        }
        
        if (self.jumpBannerDetailBlock) {
            self.jumpBannerDetailBlock(jumpUrl);
        }
    }
    
}


- (UIImageView *)createImageViewBound:(BOOL)bound cornerRadius:(CGFloat)cornerRadius {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    if (bound) {
        imageView.clipsToBounds = true;
        imageView.layer.cornerRadius = cornerRadius;
    }
    [self addSubview:imageView];
    return imageView;
}
-(void)setActivityImages:(NSArray *)activityImages{
    _activityImages = activityImages;
    for (CSBannerModel *bannerModel in _activityImages) {
        if ([bannerModel.advType isEqualToString:@"2"]) {
            [_bigImageView sd_setImageWithURL:[NSURL URLWithString:isEmptyStr(bannerModel.advUrl)?@"":bannerModel.advUrl] placeholderImage:[UIImage imageNamed:@"popup_img"]];
        }
        else if ([bannerModel.advType isEqualToString:@"3"]) {
            [_leftImageView sd_setImageWithURL:[NSURL URLWithString:isEmptyStr(bannerModel.advUrl)?@"":bannerModel.advUrl] placeholderImage:[UIImage imageNamed:@"popup_img"]];
        }
        else if ([bannerModel.advType isEqualToString:@"4"]) {
            [_rightImageView sd_setImageWithURL:[NSURL URLWithString:isEmptyStr(bannerModel.advUrl)?@"":bannerModel.advUrl] placeholderImage:[UIImage imageNamed:@"popup_img"]];
        }
    }
}

@end
