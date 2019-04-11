//
//  CSHomeHeaderView.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/20.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSHomeHeaderView.h"


@interface  CSHomeHeaderView()<SDCycleScrollViewDelegate>
{
    SDCycleScrollView *bannerView;
    
}
@end

@implementation CSHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
    //首页轮播图没有图片的时候放一张默认图，暂时没有放
    bannerView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.viewHeight) delegate:self placeholderImage:[UIImage imageNamed:@"popup_img"]];
    bannerView.currentPageDotColor = NAV_COLOR;
    bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    bannerView.autoScroll = YES;
    bannerView.backgroundColor = [UIColor whiteColor];
    bannerView.imageURLStringsGroup = @[@"popup_img",@"popup_img",@"popup_img"];
    [self addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);
    }];
}
#pragma mark --SDCycleScrollViewDelete

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if (self.bannerClick) {
        self.bannerClick(_models[index]);
    }
}



-(void)setModels:(NSArray <CSBannerModel *>*)models{
    _models = models;
    NSMutableArray *mArr = [NSMutableArray new];
    for (CSBannerModel *model in models) {
        [mArr addObject:isEmptyStr(model.advUrl)?@"":model.advUrl];
    }
    bannerView.imageURLStringsGroup = mArr;
}

@end
