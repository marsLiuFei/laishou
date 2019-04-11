//
//  CSBannerPicsCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBannerPicsCell.h"

@interface CSBannerPicsCell ()<SDCycleScrollViewDelegate>
{
    SDCycleScrollView *bannerView;
}

@end

@implementation CSBannerPicsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}
- (void )creatUI{
    //首页轮播图没有图片的时候放一张默认图，暂时没有放
    bannerView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) delegate:self placeholderImage:[UIImage imageNamed:@"popup_img"]];
    bannerView.currentPageDotColor = NAV_COLOR;
    bannerView.autoScroll = YES;
    bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    bannerView.clipsToBounds = YES;
    bannerView.backgroundColor = WhiteColor;
    [self.contentView addSubview:bannerView];
    bannerView.imageURLStringsGroup = @[@"popup_img",@"popup_img",@"popup_img"];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
}
#pragma mark --SDCycleScrollViewDelete

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (self.bannerClick) {
        self.bannerClick(index,_imageArray);
    }
}




- (void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    bannerView.imageURLStringsGroup = _imageArray;
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
