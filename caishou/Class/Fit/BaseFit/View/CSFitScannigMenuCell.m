//
//  CSFitScannigMenuCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/27.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSFitScannigMenuCell.h"
#import "CSSignUpPeopleIconCell.h"

@interface CSFitScannigMenuCell ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
@property (strong , nonatomic)UICollectionView *collectionView;

@end

@implementation CSFitScannigMenuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.offset(-SIZE(15));
            make.top.left.offset(SIZE(15));
        }];
    }
    return self;
}
-(void)setInfoDicArray:(NSArray *)infoDicArray{
    _infoDicArray = infoDicArray;
    [self.collectionView reloadData];
}

#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat margin = (SCREEN_WIDTH-SIZE(30)-4.5*SIZE(70))/4.f;
        layout.minimumLineSpacing = margin;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
        layout.itemSize = CGSizeMake(SIZE(70), SIZE(85));
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.contentView addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[CSSignUpPeopleIconCell class] forCellWithReuseIdentifier:@"CSSignUpPeopleIconCell"];
    }
    return _collectionView;
}
#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.infoDicArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSSignUpPeopleIconCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSSignUpPeopleIconCell" forIndexPath:indexPath];
    NSDictionary *dic = self.infoDicArray[indexPath.row];
    [cell setTitle:dic[@"title"] imageName:dic[@"imageName"]];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.clickBlock) {
        self.clickBlock(indexPath.row+1);
    }
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
