//
//  CSShowPicView.m
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSShowPicView.h"
#import "CSShowPicItem.h"

@interface CSShowPicView ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
@end

@implementation CSShowPicView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = WhiteColor;
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.right.bottom.offset(0);
        }];
    }
    return self;
}

-(void)setPhotos:(NSArray *)photos{
    _photos = photos;
    [self.collectionView reloadData];
}


#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = SIZE(10);
        layout.minimumInteritemSpacing = SIZE(10);
        layout.sectionInset = UIEdgeInsetsMake(SIZE(10),0,SIZE(10),0);
        CGFloat width = (SCREEN_WIDTH-SIZE(50))/3.f;
        layout.itemSize = CGSizeMake(width, SIZE(80));
        layout.scrollDirection = UICollectionViewScrollDirectionVertical; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[CSShowPicItem class] forCellWithReuseIdentifier:@"CSShowPicItem"];
    }
    return _collectionView;
}
#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSShowPicItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSShowPicItem" forIndexPath:indexPath];
    cell.imageName = self.photos[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *mArr = [NSMutableArray new];
    for (int i=0; i<self.photos.count; i++) {
        CSShowPicItem *cell = (CSShowPicItem *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [mArr addObject:cell.showImageView];
    }
    if (self.clickImageBlock) {
        self.clickImageBlock(indexPath.item, mArr, self.photos);
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
