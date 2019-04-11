//
//                       .::::.
//                     .::::::::.
//                    :::::::::::
//                 ..:::::::::::'
//              '::::::::::::'
//                .::::::::::
//           '::::::::::::::..
//                ..::::::::::::.
//              ``::::::::::::::::
//               ::::``:::::::::'        .:::.
//              ::::'   ':::::'       .::::::::.
//            .::::'      ::::     .:::::::'::::.
//           .:::'       :::::  .:::::::::' ':::::.
//          .::'        :::::.:::::::::'      ':::::.
//         .::'         ::::::::::::::'         ``::::.
//     ...:::           ::::::::::::'              ``::.
//    ```` ':.          ':::::::::'                  ::::..
//                       '.:::::'                    ':'````..
//
//  CSConvertViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSConvertViewController.h"
#import "CSconvertSuccessViewController.h"

#import "CSIntegralSignDetailModel.h"

#import "CSSignHeaderView.h"
#import "CSIngetralGoodsCell.h"

@interface CSConvertViewController ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, strong)NSMutableArray *integralGoodsList;
/**
 *
 */
@property(nonatomic, strong)CSIntegralSignDetailModel *integralSignDetailModel;

@end

@implementation CSConvertViewController

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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
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
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = COMMON_BACK_COLOR;
        _collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CSIngetralGoodsCell class] forCellWithReuseIdentifier:@"CSConverIngetralGoodsCell"];
    }
    return _collectionView;
}
#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.integralGoodsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ws(bself);
    CSIngetralGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CSConverIngetralGoodsCell" forIndexPath:indexPath];
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

@end
