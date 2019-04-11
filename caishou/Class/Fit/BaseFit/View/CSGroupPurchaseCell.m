//
//  CSGroupPurchaseCell.m
//  caishou
//
//  Created by 刘飞 on 2019/2/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSGroupPurchaseCell.h"

#import "CSSignUpPeopleIconCell.h"

@interface CSGroupPurchaseCell ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
/**
 *
 **/
@property(nonatomic, strong)UILabel *la;
/**
 *  拼团人数
 */
@property(nonatomic, strong)NSArray *menberList;
@end

@implementation CSGroupPurchaseCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WhiteColor;
        [self creatUI];
    }
    return self;
}
- (void )creatUI{
    self.la = [ViewCreate createLabelFrame:CGRectMake(0, 0, 0, 0) backgroundColor:ClearColor text:@"参团成员(266)" textColor:RGB44 textAlignment:Left font:MediumFont(16)];
    [self.contentView addSubview:self.la];
    [self.la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(SIZE(15));
        make.height.offset(SIZE(25));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.la.mas_bottom).offset(SIZE(15));
        make.right.bottom.offset(-SIZE(15));
        make.left.offset(SIZE(15));
    }];
    
}
-(void)setMenberList:(NSArray *)menberList spellNumber:(NSString *)spellNumber{
    self.la.text = [NSString stringWithFormat:@"参团成员(%ld)，满%@人拼团成功",(menberList.count>0)?menberList.count:0,spellNumber];
    self.menberList = menberList;
    [self.collectionView reloadData];
}


#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat margin = (SCREEN_WIDTH-SIZE(30)-SIZE(70)*5)/4.f;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = margin;
        layout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
        layout.itemSize = CGSizeMake(SIZE(70), SIZE(85));
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
    return self.menberList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CSSignUpPeopleIconCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSSignUpPeopleIconCell" forIndexPath:indexPath];
    cell.memberModel = self.menberList[indexPath.row];
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
