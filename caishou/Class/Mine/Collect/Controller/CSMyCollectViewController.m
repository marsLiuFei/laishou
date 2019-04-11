//
//  CSMyCollectViewController.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/9.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSMyCollectViewController.h"

#import "CSMyCollectModel.h"

#import "CSMyCollectCell.h"

@interface CSMyCollectViewController ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)NSMutableArray *collectList;
@end

@implementation CSMyCollectViewController
-(NSMutableArray *)collectList{
    if (!_collectList) {
        _collectList = [NSMutableArray new];
    }
    return _collectList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self setNavTitleStr:@"我的收藏"];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.bottom.offset(0);
    }];
    [self addRefresh];
    [self loadData];
}

- (void )addRefresh{
    ws(bself);
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        bself.page = 1;
        [bself loadData];
    }];
    //    [_collectionView.mj_header beginRefreshing];
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        bself.page ++;
        [bself loadData];
    }];
}
- (void)loadData {
    ws(bself);
    NSMutableDictionary *paramDic = @{@"substationId":[UDefault getObject:NowSiteId],@"page":@(self.page),@"rows":@"10"}.mutableCopy;
    NSDictionary *locationDic = [UDefault getValue:NowLocationDic];
    [paramDic addEntriesFromDictionary:locationDic];
    [CSApiManager myArticlePageWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        [self->_collectionView.mj_header endRefreshing];
        [self->_collectionView.mj_footer endRefreshing];
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            NSArray *arr = [CSMyCollectModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
            if (arr.count>0) {
                if (bself.page>1) {
                    [bself.collectList addObjectsFromArray:arr];
                }
                else{
                    bself.collectList = arr.mutableCopy;
                }
            }
            else{
                if (bself.page>1) {
                    
                }
                else{
                    bself.collectList = nil;
                }
            }
            [bself.collectionView reloadData];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
        [self->_collectionView.mj_header endRefreshing];
        [self->_collectionView.mj_footer endRefreshing];
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
        layout.itemSize = CGSizeMake(width, width+SIZE(90));
        layout.scrollDirection = UICollectionViewScrollDirectionVertical; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = COMMON_BACK_COLOR;
        _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[CSMyCollectCell class] forCellWithReuseIdentifier:@"CSMyCollectCell"];
    }
    return _collectionView;
}
#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CSMyCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSMyCollectCell" forIndexPath:indexPath];
    CSMyCollectModel *collectModel = self.collectList[indexPath.item];
    cell.collectModel = collectModel;
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CSMyCollectModel *collectModel = self.collectList[indexPath.row];
    [self loadHtmlContents:collectModel.articleContent isShare:true collect:true chirleId:collectModel.ID shareContent:collectModel.articleTitle shareIcon:collectModel.img];
}





@end

