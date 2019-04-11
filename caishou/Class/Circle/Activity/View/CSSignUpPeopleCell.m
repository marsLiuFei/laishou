//
//  CSSignUpPeopleCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSSignUpPeopleCell.h"

#import "CSSignUpPeopleIconCell.h"

@interface CSSignUpPeopleCell ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
{
    UILabel *signUpCountLabel;//已报名人数
    UIButton *moreBtn;
}
@property (strong , nonatomic)UICollectionView *collectionView;
@end

@implementation CSSignUpPeopleCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
        
        signUpCountLabel = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"已报名人数(0)" textColor:BlackColor textAlignment:Left font:FONT(14)];
        [self.contentView addSubview:signUpCountLabel];
        [signUpCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(SIZE(15));
        }];
        
        moreBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"更多报名 >" titleColor:MainColor font:FONT(14) backgroundColor:ClearColor touchUpInsideEvent:nil];
        [moreBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-SIZE(15));
            make.centerY.mas_equalTo(self->signUpCountLabel.mas_centerY).offset(0);
        }];
        
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self->signUpCountLabel.mas_bottom).offset(SIZE(20));
            make.right.bottom.offset(-SIZE(15));
            make.left.offset(SIZE(15));
        }];
    }
    return self;
}

- (void )clickBtn{
    if (self.clickMoreBtnBlock) {
        self.clickMoreBtnBlock();
    }
}

-(void)setModels:(NSArray *)models{
    _models = models;
    signUpCountLabel.text = [NSString stringWithFormat:@"已报名人数(%ld)",_models.count];
    [self.collectionView reloadData];
}

#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = SIZE(15);
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
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSSignUpPeopleIconCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSSignUpPeopleIconCell" forIndexPath:indexPath];
    cell.memberModel = self.models[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
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
