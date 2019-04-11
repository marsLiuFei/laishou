//
//  CSSignInViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/2/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSSignInViewController.h"
#import "CSconvertSuccessViewController.h"
#import "CSSignActivityViewController.h"
#import "CSShareArticleViewController.h"
#import "CSBaseFitViewController.h"
#import "CSConvertViewController.h"

#import "CSIntegralSignDetailModel.h"

#import "CSSignHeaderView.h"
#import "CSIngetralGoodsCell.h"

@interface CSSignInViewController ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)NSMutableArray *integralGoodsList;
/**
 *
 */
@property(nonatomic, strong)CSIntegralSignDetailModel *integralSignDetailModel;
@end

@implementation CSSignInViewController

-(CSIntegralSignDetailModel *)integralSignDetailModel{
    if (!_integralSignDetailModel) {
        _integralSignDetailModel = [CSIntegralSignDetailModel new];
    }
    return _integralSignDetailModel;
}

-(NSMutableArray *)integralGoodsList{
    if (!_integralGoodsList) {
        _integralGoodsList = [NSMutableArray new];
    }
    return _integralGoodsList;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:WhiteColor};
    self.navigationController.navigationBar.tintColor = WhiteColor;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor]};
    self.navigationController.navigationBar.tintColor = MainColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitleStr:@"每日签到"];
    self.page = 1;
    
//    if (isEmptyStr(self.formVcName)) {
//        //未传值说明是从main跳转进签到页面
//        self.isSigned = [Dialog Instance].isSigned;
//    }
    
    CGFloat top = kTopHeight;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(-top);
        make.left.right.bottom.offset(0);
    }];
    [self addRefresh];
    [self loadData];
}

- (void )addRefresh{
    ws(bself);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        bself.page = 1;
        [bself loadData];
    }];
    //    [self.collectionView.mj_header beginRefreshing];
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
    [CSApiManager goodsPageWithParamDic:paramDic CallBack:^(id  _Nonnull data) {
        [bself.collectionView.mj_header endRefreshing];
        [bself.collectionView.mj_footer endRefreshing];
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            bself.integralSignDetailModel = [CSIntegralSignDetailModel mj_objectWithKeyValues:data[@"data"]];
            NSArray *arr = [CSIntegralGoodsModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
            if (arr.count>0) {
                if (bself.page>1) {
                    [bself.integralGoodsList addObjectsFromArray:arr];
                }
                else{
                    bself.integralGoodsList = arr.mutableCopy;
                }
            }
            else{
                if (bself.page>1) {
                    
                }
                else{
                    bself.integralGoodsList = nil;
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
        layout.minimumLineSpacing = SIZE(1);
        layout.minimumInteritemSpacing = SIZE(1);
        layout.sectionInset = UIEdgeInsetsMake(0,0,0,0);
        CGFloat width = (SCREEN_WIDTH-SIZE(1))/2.f;
        layout.itemSize = CGSizeMake(width, SIZE(236));
        BOOL isPhoneX = [[UIApplication sharedApplication] statusBarFrame].size.height>20;
        layout.headerReferenceSize = isPhoneX?CGSizeMake(SCREEN_WIDTH, SIZE(404)):CGSizeMake(SCREEN_WIDTH, SIZE(380));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = COMMON_BACK_COLOR;
        _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[CSSignHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CSSignHeaderView"];
        [_collectionView registerClass:[CSIngetralGoodsCell class] forCellWithReuseIdentifier:@"CSIngetralGoodsCell"];
    }
    return _collectionView;
}
#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.integralGoodsList.count;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ws(bself);
    CSSignHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CSSignHeaderView" forIndexPath:indexPath];
    header.IntegralSignDetailModel = self.integralSignDetailModel;
    header.signBtnClickBlock = ^{
        [bself clickSignBtn];
    };
    header.activityBtnClickBlock = ^{
        [bself clickActivityBtn];
    };
    header.articleBtnClickBlock = ^{
        [bself clickArticleBtn];
    };
    header.groupBtnClickBlock = ^{
        [bself groupArticleBtn];
    };
    header.convertBtnClickBlock = ^{
        [bself convertArticleBtn];
    };
    return header;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ws(bself);
    CSIngetralGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSIngetralGoodsCell" forIndexPath:indexPath];
    CSIntegralGoodsModel *integralModel = self.integralGoodsList[indexPath.item];
    cell.integralGoodsModel = integralModel;
    cell.clickBtnBlock = ^(NSString * _Nonnull goodsID) {
        [bself exchangeIntegralGoodsWithID:goodsID];
    };
    return cell;
}
//积分兑换商品
- (void )exchangeIntegralGoodsWithID:(NSString *)goodsId{
    ws(bself);
    [CSApiManager exchangeIntegralGoodsWithParamDic:@{@"substationId":[UDefault getObject:NowSiteId],@"id":isEmptyStr(goodsId)?@"":goodsId,@"number":@"1"} CallBack:^(id  _Nonnull data) {
        [Dialog toastCenter:BackMessage];
        if (ResultIsCorrect) {
            [NSNotic_Center postNotificationName:PayIntegralGoodsSuccess object:nil];
            [bself.navigationController pushViewController:[CSconvertSuccessViewController new] animated:YES];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}



#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - click
- (void)clickActivityBtn{
    CSSignActivityViewController *vc = [[CSSignActivityViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}
- (void)clickArticleBtn {
    CSShareArticleViewController *vc = [[CSShareArticleViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}
- (void)groupArticleBtn {
    
    CSBaseFitViewController *vc = [[CSBaseFitViewController alloc] init];
    vc.showTitle = true;
    [self.navigationController pushViewController:vc animated:true];
}
- (void)convertArticleBtn {
    CSConvertViewController *vc = [[CSConvertViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}
//点击了签到按钮
- (void )clickSignBtn{
    ws(bself);
    [CSApiManager daySignCallBack:^(id  _Nonnull data) {
        MYLog(@"%@",data);
        if (ResultIsCorrect) {
            [Dialog toastCenter:@"签到成功！"];
            [Dialog Instance].isSigned = YES;
            //签到成功后刷新页面
            [bself.collectionView.mj_header beginRefreshing];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}

@end
