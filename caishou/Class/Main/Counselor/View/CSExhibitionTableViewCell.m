//
//  CSExhibitionTableViewCell.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSExhibitionTableViewCell.h"
#import "CSImageShowCollectionCell.h"
#import "CSCounselorMienListModel.h"

@interface CSExhibitionTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** collectionView */
@property(nonatomic , strong)UICollectionView *collectionView;
/** pushController */
@property(nonatomic , strong)NSArray *pushControllers;



@end

@implementation CSExhibitionTableViewCell

const CGFloat kspace = 10;
NSString *kImageShowColl = @"kImageShowColl";

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
        
    }
    return self;
}
-(void)setSourceData:(NSArray *)sourceData{
    _sourceData = sourceData;
    [self.collectionView reloadData];
}

#pragma mark - setupUI
- (void)setupUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView = collectionView;
    collectionView.backgroundColor = WhiteColor;
    CGFloat width = (SCREEN_WIDTH - SIZE(30))/4.f;
    flowLayout.itemSize = CGSizeMake(width,width);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0,SIZE(15),0,SIZE(15));
    
    [collectionView registerClass:[CSImageShowCollectionCell class] forCellWithReuseIdentifier:kImageShowColl];
    collectionView.delegate = self;
    collectionView.dataSource  = self;
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sourceData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CSImageShowCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kImageShowColl forIndexPath:indexPath];
    CSCounselorMienListModel *model = self.sourceData[indexPath.row];
    cell.menberModel = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSMutableArray *mArr = [NSMutableArray new];
    
    for (int i = 0; i < self.sourceData.count; i++) {
        CSImageShowCollectionCell *cell = (CSImageShowCollectionCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [mArr addObject:cell.icon];
    }
    
    NSMutableArray *imgs = [NSMutableArray new];
    for (int i=0; i<self.self.sourceData.count; i++) {
       CSCounselorMienListModel *model = self.sourceData[i];
        [imgs addObject:model.picture];
    }
    if (self.clickImageBlock) {
        self.clickImageBlock(indexPath.item, mArr, imgs);
    }
}



@end
