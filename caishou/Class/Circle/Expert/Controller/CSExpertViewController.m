//
//  CSExpertViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/2/21.
//  Copyright © 2019年 mars. All rights reserved.
//  达人

#import "CSExpertViewController.h"

#import "CSSevereUserPageModel.h"

#import "CSOptimizeCell.h"

@interface CSExpertViewController ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
/**
 *  所有cell的icon
 */
@property(nonatomic, strong)NSMutableArray *nowSubViews;
@property(nonatomic, strong)NSMutableArray *severeUserPageArray;
@property(nonatomic, assign)NSInteger page;
@end

@implementation CSExpertViewController
-(NSMutableArray *)nowSubViews{
    if (!_nowSubViews) {
        _nowSubViews = [NSMutableArray new];
    }
    return _nowSubViews;
}
-(NSMutableArray *)severeUserPageArray{
    if (!_severeUserPageArray) {
        _severeUserPageArray = [NSMutableArray new];
    }
    return _severeUserPageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];//
    self.page = 1;
    CGFloat bottomMargin = -kTopHeight;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(bottomMargin);
    }];
    [self addRefresh];
//    [self loadData];
}

- (void )addRefresh{
    ws(bself);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        bself.page = 1;
        [bself loadData];
    }];
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        bself.page ++;
        [bself loadData];
    }];
}
- (void)loadData {
    ws(bself);
    NSMutableDictionary *paramDic = @{@"substationId":[UDefault getObject:NowSiteId],@"page":@(self.page),@"rows":@"10"}.mutableCopy;
    NSDictionary *locationDic = [UDefault getValue:NowLocationDic];
    [paramDic addEntriesFromDictionary:locationDic];
    [CSApiManager severeUserPageWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        [bself.collectionView.mj_header endRefreshing];
        [bself.collectionView.mj_footer endRefreshing];
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            NSArray *arr = [CSSevereUserPageModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
            if (arr.count>0) {
                if (bself.page>1) {
                    [bself.severeUserPageArray addObjectsFromArray:arr];
                }
                else{
                    bself.severeUserPageArray = arr.mutableCopy;
                }
            }
            else{
                if (bself.page>1) {
                    
                }
                else{
                    bself.severeUserPageArray = nil;
                }
            }
            [bself.nowSubViews removeAllObjects];
            [bself.collectionView reloadData];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
        [bself.collectionView.mj_header endRefreshing];
        [bself.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = SIZE(15);
        layout.minimumInteritemSpacing = SIZE(15);
        layout.sectionInset = UIEdgeInsetsMake(0,SIZE(15),0,SIZE(15));
        CGFloat width = (SCREEN_WIDTH-SIZE(45))/2.f;
        layout.itemSize = CGSizeMake(width,SIZE(120));
        layout.scrollDirection = UICollectionViewScrollDirectionVertical; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[CSOptimizeCell class] forCellWithReuseIdentifier:@"CSOptimizeCell"];
    }
    return _collectionView;
}
#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.severeUserPageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSOptimizeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSOptimizeCell" forIndexPath:indexPath];
    CSSevereUserPageModel *severeUserPageModel = self.severeUserPageArray[indexPath.row];
    cell.severeUserModel = severeUserPageModel;
    [self.nowSubViews addObject:cell.icon];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSMutableArray *arrM = [NSMutableArray new];
////    NSMutableArray *subViews = [NSMutableArray new];
//    for (int i = 0;  i < self.severeUserPageArray.count; i ++) {
//        CSSevereUserPageModel *severeUserPageModel = self.severeUserPageArray[i];
////        CSOptimizeCell *cell = (CSOptimizeCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
////        [subViews addObject:cell.icon];
//        [arrM addObject:severeUserPageModel.headImg];
//    }
//    [self post:indexPath.row subviews:self.nowSubViews arr:arrM];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
