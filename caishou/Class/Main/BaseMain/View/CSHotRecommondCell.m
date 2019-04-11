//
//  CSHotRecommondCell.m
//  caishou
//
//  Created by 刘飞 on 2019/3/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSHotRecommondCell.h"

#import "CSHotNewsItem.h"

@interface CSHotRecommondCell ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
@end

@implementation CSHotRecommondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}

- (void )creatUI{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.bottom.offset(0);
    }];
}




#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = SIZE(10);
        layout.minimumInteritemSpacing = SIZE(10);
        layout.sectionInset = UIEdgeInsetsMake(SIZE(10),SIZE(15),SIZE(10),SIZE(15));
        CGFloat width = (SCREEN_WIDTH-SIZE(50))/2.f;
        layout.itemSize = CGSizeMake(width, SIZE(180));
        layout.scrollDirection = UICollectionViewScrollDirectionVertical; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.contentView addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[CSHotNewsItem class] forCellWithReuseIdentifier:@"CSHotNewsItem"];
    }
    return _collectionView;
}
#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.articleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSHotNewsItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSHotNewsItem" forIndexPath:indexPath];
    cell.articleModel = self.articleArray[indexPath.row];
    cell.clipsToBounds = true;
    cell.layer.cornerRadius = 5;
    cell.layer.borderColor = RGB(220, 220, 220).CGColor;
    cell.layer.borderWidth = 1;
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CSArticleListModel *articleModel = self.articleArray[indexPath.row];
    if (self.collectionViewBlock) {
        self.collectionViewBlock(articleModel);
    }
    
}



- (void)setArticleArray:(NSArray<CSArticleListModel *> *)articleArray {
    _articleArray = articleArray;
    [self.collectionView reloadData];
}

@end
