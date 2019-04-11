//
//  CSSpecialInterviewViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/2/21.
//  Copyright © 2019年 mars. All rights reserved.
//  专访

#import "CSSpecialInterviewViewController.h"

#import "CSArticleListModel.h"

#import "CSSpecoalInterviewCell.h"

@interface CSSpecialInterviewViewController ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)NSMutableArray *activityArray;
@end

@implementation CSSpecialInterviewViewController

-(NSMutableArray *)activityArray{
    if (!_activityArray) {
        _activityArray = [NSMutableArray new];
    }
    return _activityArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        bself.page = 1;
        [bself loadData];
    }];
    [_collectionView.mj_header beginRefreshing];
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        bself.page ++;
        [bself loadData];
    }];
}
- (void)loadData {
    ws(bself);
    NSMutableDictionary *paramDic = @{@"substationId":[UDefault getObject:NowSiteId],@"page":@(self.page),@"rows":@"10",@"articleType":@"3"}.mutableCopy;
    NSDictionary *locationDic = [UDefault getValue:NowLocationDic];
    [paramDic addEntriesFromDictionary:locationDic];
    [CSApiManager articlePageWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        [self->_collectionView.mj_header endRefreshing];
        [self->_collectionView.mj_footer endRefreshing];
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            NSArray *arr = [CSArticleListModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
            if (arr.count>0) {
                if (bself.page>1) {
                    [bself.activityArray addObjectsFromArray:arr];
                }
                else{
                    bself.activityArray = arr.mutableCopy;
                }
            }
            else{
                if (bself.page>1) {
                    
                }
                else{
                    bself.activityArray = nil;
                }
            }
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
        layout.minimumLineSpacing = SIZE(10);
        layout.minimumInteritemSpacing = SIZE(10);
        layout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
        CGFloat width = (SCREEN_WIDTH-SIZE(10))/2.f;
        layout.itemSize = CGSizeMake(width,SIZE(150));
        layout.scrollDirection = UICollectionViewScrollDirectionVertical; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[CSSpecoalInterviewCell class] forCellWithReuseIdentifier:@"CSSpecoalInterviewCell"];
    }
    return _collectionView;
}
#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.activityArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSSpecoalInterviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSSpecoalInterviewCell" forIndexPath:indexPath];
    cell.activityModel = self.activityArray[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CSArticleListModel *activityModel = self.activityArray[indexPath.row];
    if (activityModel.isVideo) {
        [self videoPlayerWithUrl:activityModel.articleContent placeholdImage:activityModel.img];
        
        
    }else{
        [self loadHtmlContents:activityModel.articleContent];
    }
    
    
    
    
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
