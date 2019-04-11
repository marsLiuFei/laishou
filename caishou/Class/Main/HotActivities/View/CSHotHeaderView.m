//
//  CSHotHeaderView.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSHotHeaderView.h"
#import "CSHotOptionCollectionCell.h"

@interface  CSHotHeaderView()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    SDCycleScrollView *bannerView;
    UICollectionView *_collectionView;
    
}
@end
@implementation CSHotHeaderView

NSString *kCSHotOptionCollectionCell = @"kCSHotOptionCollectionCell";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    CSBannerModel *model = self.models[index];
    if (self.bannerClick) {
        self.bannerClick(model.url);
    }
}
#pragma mark - createUI

-(void)createUI {
    //首页轮播图没有图片的时候放一张默认图，暂时没有放
    bannerView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.viewHeight * 0.5) delegate:self placeholderImage:[UIImage imageNamed:@"popup_img"]];
    bannerView.currentPageDotColor = NAV_COLOR;
    bannerView.autoScroll = YES;
    bannerView.backgroundColor = [UIColor whiteColor];
    bannerView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    NSString *pics = [CSCommonHelper Instance].ActivityPosterModel.advUrl;
    bannerView.imageURLStringsGroup = @[isEmptyStr(pics)?@"":pics];
    [self addSubview:bannerView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(SIZE(10), 0, SIZE(10), 0);
    CGFloat width = self.viewWidth / 5;
    flowLayout.itemSize = CGSizeMake(width, width);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, bannerView.viewHeight, SCREEN_WIDTH, self.viewHeight * 0.5) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"CSHotOptionCollectionCell" bundle:nil] forCellWithReuseIdentifier:kCSHotOptionCollectionCell];
    [self addSubview:_collectionView];
}



#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.optionsModels.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CSHotOptionCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCSHotOptionCollectionCell forIndexPath:indexPath];
    
     CSHotOptionModel *model =    self.optionsModels[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:model.iconStr];
    cell.titleLabel.text = model.title;
    cell.titleLabel.font = RegularFont(16);
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectOptionBlock) {
        self.selectOptionBlock(indexPath.item, self.optionsModels[indexPath.item]);
    }
}
#pragma mark --SDCycleScrollViewDelete


-(void)setModels:(NSArray <CSBannerModel *>*)models{
    _models = models;
    NSMutableArray *mArr = [NSMutableArray new];
    for (CSBannerModel *model in models) {
        [mArr addObject:isEmptyStr(model.advUrl)?@"":model.advUrl];
    }
    bannerView.imageURLStringsGroup = mArr;
}

- (void)setOptionsModels:(NSArray<CSHotOptionModel *> *)optionsModels {
    _optionsModels = optionsModels;
    [_collectionView reloadData];
}
@end
